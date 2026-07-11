import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/timer_task.dart';
import '../../domain/schedule/schedule_calculator.dart';
import '../database/app_database.dart';

/// 定时器数据仓库：在 drift 生成的表行（[TimerTaskEntity]）与领域模型
/// （[TimerTask]）之间做双向映射，UI/状态层只与领域模型打交道。
class TimerRepository {
  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  TimerRepository(this._db);

  /// 持续监听全部定时器（按下一次触发时间排序，未设置的排最后）。
  Stream<List<TimerTask>> watchAll() {
    final query = _db.select(_db.timerTasksTable)
      ..orderBy([
        (t) => OrderingTerm(expression: t.nextTriggerAt, mode: OrderingMode.asc, nulls: NullsOrder.last),
      ]);
    return query.watch().map((rows) => rows.map(_toDomain).toList());
  }

  Future<List<TimerTask>> loadAll() async {
    final rows = await _db.select(_db.timerTasksTable).get();
    return rows.map(_toDomain).toList();
  }

  Future<TimerTask?> findById(String id) async {
    final row = await (_db.select(_db.timerTasksTable)..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  /// 新建定时器：生成 id / 时间戳，并立即计算首次的 nextTriggerAt。
  Future<TimerTask> create(TimerTask draft) async {
    final now = DateTime.now();
    var task = draft.copyWith(id: _uuid.v4(), updatedAt: now);
    task = task.copyWith(nextTriggerAt: const ScheduleCalculator().computeNextTrigger(task, now));
    await _db.into(_db.timerTasksTable).insert(_toCompanion(task, createdAt: now));
    return task;
  }

  /// 更新已有定时器（编辑保存）：统一在此重新计算 nextTriggerAt，调用方
  /// （编辑页）无需关心触发规则细节。对 countdown 类型而言，这意味着
  /// "编辑并保存"等价于"从当前时刻重新开始倒计时"，语义简单且可预期。
  Future<void> update(TimerTask task) async {
    final now = DateTime.now();
    final recomputed = const ScheduleCalculator().computeNextTrigger(
      task.copyWith(clearNextTriggerAt: true),
      now,
    );
    final updated = task.copyWith(nextTriggerAt: recomputed, clearNextTriggerAt: recomputed == null, updatedAt: now);
    await _db.into(_db.timerTasksTable).insertOnConflictUpdate(_toCompanion(updated, createdAt: task.createdAt));
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.timerTasksTable)..where((t) => t.id.equals(id))).go();
  }

  Future<void> setEnabled(String id, bool enabled) async {
    if (enabled) {
      final task = await findById(id);
      if (task == null) return;
      final nextTriggerAt = const ScheduleCalculator().computeNextTrigger(task, DateTime.now());
      await (_db.update(_db.timerTasksTable)..where((t) => t.id.equals(id))).write(
        TimerTasksTableCompanion(
          enabled: const Value(true),
          nextTriggerAt: Value(nextTriggerAt),
          updatedAt: Value(DateTime.now()),
        ),
      );
      return;
    }
    await (_db.update(_db.timerTasksTable)..where((t) => t.id.equals(id))).write(
      TimerTasksTableCompanion(enabled: const Value(false), updatedAt: Value(DateTime.now())),
    );
  }

  /// 记录一次触发：更新 lastTriggeredAt / triggeredCount / nextTriggerAt。
  ///
  /// `nextTriggerAt` 为 null 表示该定时器不会再触发（一次性已完成，或周期性
  /// 已达结束条件），此时仅表现为列表中不再展示"下一次触发时间"，
  /// `enabled` 开关本身保持用户上一次的设置，语义上两者是独立的。
  Future<void> markTriggered(String id, {required DateTime triggeredAt, required DateTime? nextTriggerAt}) async {
    final row = await (_db.select(_db.timerTasksTable)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return;
    await (_db.update(_db.timerTasksTable)..where((t) => t.id.equals(id))).write(
      TimerTasksTableCompanion(
        lastTriggeredAt: Value(triggeredAt),
        triggeredCount: Value(row.triggeredCount + 1),
        nextTriggerAt: Value(nextTriggerAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateNextTrigger(String id, DateTime? nextTriggerAt) async {
    await (_db.update(_db.timerTasksTable)..where((t) => t.id.equals(id))).write(
      TimerTasksTableCompanion(nextTriggerAt: Value(nextTriggerAt), updatedAt: Value(DateTime.now())),
    );
  }

  TimerTask _toDomain(TimerTaskEntity row) {
    final dailyMinutes = row.dailyTimesJson == null
        ? const <int>[]
        : (jsonDecode(row.dailyTimesJson!) as List).cast<int>();
    final weekdays = row.weekdaysJson == null ? const <int>[] : (jsonDecode(row.weekdaysJson!) as List).cast<int>();

    EndCondition endCondition;
    switch (row.endConditionType) {
      case 'byDate':
        endCondition = EndCondition.byDate(row.endDate ?? DateTime.now());
        break;
      case 'byCount':
        endCondition = EndCondition.byCount(row.endCount ?? 0);
        break;
      default:
        endCondition = const EndCondition.never();
    }

    return TimerTask(
      id: row.id,
      name: row.name,
      message: row.message,
      type: TimerType.values.byName(row.type),
      enabled: row.enabled,
      triggerAt: row.triggerAt,
      countdownSeconds: row.countdownSeconds,
      intervalSeconds: row.intervalSeconds,
      dailyTimes: dailyMinutes.map(minutesToTimeOfDay).toList(),
      weekdays: weekdays,
      activeStart: row.activeStartMinutes == null ? null : minutesToTimeOfDay(row.activeStartMinutes!),
      activeEnd: row.activeEndMinutes == null ? null : minutesToTimeOfDay(row.activeEndMinutes!),
      endCondition: endCondition,
      triggeredCount: row.triggeredCount,
      sound: SoundConfig(enabled: row.soundEnabled, soundId: row.soundId, volume: row.soundVolume),
      notify: row.notify,
      popup: row.popup,
      snoozeMinutes: row.snoozeMinutes,
      forceRest: row.forceRest,
      restDurationMinutes: row.restDurationMinutes,
      lastTriggeredAt: row.lastTriggeredAt,
      nextTriggerAt: row.nextTriggerAt,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  TimerTasksTableCompanion _toCompanion(TimerTask task, {required DateTime createdAt}) {
    return TimerTasksTableCompanion(
      id: Value(task.id),
      name: Value(task.name),
      message: Value(task.message),
      type: Value(task.type.name),
      enabled: Value(task.enabled),
      triggerAt: Value(task.triggerAt),
      countdownSeconds: Value(task.countdownSeconds),
      intervalSeconds: Value(task.intervalSeconds),
      dailyTimesJson: Value(jsonEncode(task.dailyTimes.map(timeOfDayToMinutes).toList())),
      weekdaysJson: Value(jsonEncode(task.weekdays)),
      activeStartMinutes: Value(task.activeStart == null ? null : timeOfDayToMinutes(task.activeStart!)),
      activeEndMinutes: Value(task.activeEnd == null ? null : timeOfDayToMinutes(task.activeEnd!)),
      endConditionType: Value(task.endCondition.type.name),
      endDate: Value(task.endCondition.date),
      endCount: Value(task.endCondition.count),
      triggeredCount: Value(task.triggeredCount),
      soundEnabled: Value(task.sound.enabled),
      soundId: Value(task.sound.soundId),
      soundVolume: Value(task.sound.volume),
      notify: Value(task.notify),
      popup: Value(task.popup),
      snoozeMinutes: Value(task.snoozeMinutes),
      forceRest: Value(task.forceRest),
      restDurationMinutes: Value(task.restDurationMinutes),
      lastTriggeredAt: Value(task.lastTriggeredAt),
      nextTriggerAt: Value(task.nextTriggerAt),
      createdAt: Value(createdAt),
      updatedAt: Value(task.updatedAt),
    );
  }
}
