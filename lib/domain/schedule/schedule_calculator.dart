import 'package:flutter/material.dart' show TimeOfDay;

import '../models/timer_task.dart';

/// 触发规则计算引擎（纯 Dart，可单元测试）
///
/// 负责根据 [TimerTask] 的类型与规则，计算出下一次应触发的时间。
/// 设计要点（对应需求文档 8.3）：
/// - "计算下一次触发时间 + 定时唤醒"模型。
/// - 触发时间落在关机/休眠期间不补发提醒：once/countdown 类型若目标时间已过，
///   直接判定为过期（返回 null）；interval/daily/weekly 类型则跳过所有已错过的
///   触发点，直接计算出 now 之后最近的一次。
class ScheduleCalculator {
  const ScheduleCalculator();

  /// 计算下一次触发时间。
  ///
  /// 返回 null 表示该定时器不会再触发（一次性已过期，或周期性已达结束条件）。
  DateTime? computeNextTrigger(TimerTask task, DateTime now) {
    switch (task.type) {
      case TimerType.once:
        return _computeOnce(task, now);
      case TimerType.countdown:
        return _computeCountdown(task, now);
      case TimerType.interval:
        return _computeInterval(task, now);
      case TimerType.daily:
        return _computeDaily(task, now, requireWeekdayMatch: false);
      case TimerType.weekly:
        return _computeDaily(task, now, requireWeekdayMatch: true);
    }
  }

  DateTime? _computeOnce(TimerTask task, DateTime now) {
    final triggerAt = task.triggerAt;
    if (triggerAt == null) return null;
    return triggerAt.isAfter(now) ? triggerAt : null;
  }

  DateTime? _computeCountdown(TimerTask task, DateTime now) {
    // 倒计时的目标时间在创建时刻就已固定；重启后只校验是否已过期，
    // 不会用当前 now 重新叠加 countdownSeconds（否则等价于重新开始倒计时）。
    final existing = task.nextTriggerAt;
    if (existing != null) {
      return existing.isAfter(now) ? existing : null;
    }
    final seconds = task.countdownSeconds;
    if (seconds == null) return null;
    return now.add(Duration(seconds: seconds));
  }

  DateTime? _computeInterval(TimerTask task, DateTime now) {
    final intervalSeconds = task.intervalSeconds;
    if (intervalSeconds == null || intervalSeconds <= 0) return null;

    final anchor = task.lastTriggeredAt ?? task.createdAt;
    final intervalMs = intervalSeconds * 1000;
    final elapsedMs = now.difference(anchor).inMilliseconds;

    DateTime candidate;
    if (elapsedMs <= 0) {
      candidate = anchor.add(Duration(milliseconds: intervalMs));
    } else {
      final steps = (elapsedMs / intervalMs).ceil();
      candidate = anchor.add(Duration(milliseconds: intervalMs * (steps <= 0 ? 1 : steps)));
      // 保护性修正，避免浮点/整数误差导致 candidate 没有严格晚于 now。
      while (!candidate.isAfter(now)) {
        candidate = candidate.add(Duration(milliseconds: intervalMs));
      }
    }

    candidate = _applyWeekdayFilter(task, candidate, intervalMs: intervalMs);
    candidate = _applyActiveWindow(task, candidate, intervalMs: intervalMs);

    return _applyEndCondition(task, candidate);
  }

  /// daily / weekly 共用的"每日固定时刻"计算。
  DateTime? _computeDaily(TimerTask task, DateTime now, {required bool requireWeekdayMatch}) {
    if (task.dailyTimes.isEmpty) return null;
    if (requireWeekdayMatch && task.weekdays.isEmpty) return null;

    final today = DateTime(now.year, now.month, now.day);
    for (var dayOffset = 0; dayOffset <= 7; dayOffset++) {
      final day = today.add(Duration(days: dayOffset));
      if (requireWeekdayMatch && !task.weekdays.contains(day.weekday)) {
        continue;
      }
      DateTime? bestOfDay;
      for (final t in task.dailyTimes) {
        final candidate = day.add(Duration(hours: t.hour, minutes: t.minute));
        if (candidate.isAfter(now)) {
          if (bestOfDay == null || candidate.isBefore(bestOfDay)) {
            bestOfDay = candidate;
          }
        }
      }
      if (bestOfDay != null) {
        return _applyEndCondition(task, bestOfDay);
      }
    }
    return null;
  }

  /// 对 interval 类型应用星期过滤：若命中的候选时间所在星期不在 weekdays 中，
  /// 则按 interval 步长继续前进，直到落在允许的星期内。
  DateTime _applyWeekdayFilter(TimerTask task, DateTime candidate, {required int intervalMs}) {
    if (task.weekdays.isEmpty) return candidate;
    var result = candidate;
    var guard = 0;
    while (!task.weekdays.contains(result.weekday) && guard < 7 * 24 * 3600) {
      result = result.add(Duration(milliseconds: intervalMs));
      guard++;
    }
    return result;
  }

  /// 对 interval 类型应用生效时段限制：若候选时间落在 [activeStart, activeEnd)
  /// 之外，则前移到下一个窗口开始时间。
  DateTime _applyActiveWindow(TimerTask task, DateTime candidate, {required int intervalMs}) {
    final start = task.activeStart;
    final end = task.activeEnd;
    if (start == null || end == null) return candidate;

    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    if (startMinutes >= endMinutes) return candidate; // 暂不支持跨午夜窗口

    var result = candidate;
    var guard = 0;
    while (guard < 60) {
      final minutesOfDay = result.hour * 60 + result.minute;
      if (minutesOfDay >= startMinutes && minutesOfDay < endMinutes) {
        return result;
      }
      final day = DateTime(result.year, result.month, result.day);
      if (minutesOfDay < startMinutes) {
        result = day.add(Duration(minutes: startMinutes));
      } else {
        result = day.add(Duration(days: 1, minutes: startMinutes));
      }
      guard++;
    }
    return result;
  }

  /// 应用周期性结束条件（永不 / 到某日期 / 触发 N 次后停止）。
  DateTime? _applyEndCondition(TimerTask task, DateTime candidate) {
    switch (task.endCondition.type) {
      case EndConditionType.never:
        return candidate;
      case EndConditionType.byDate:
        final endDate = task.endCondition.date;
        if (endDate != null && candidate.isAfter(endDate)) return null;
        return candidate;
      case EndConditionType.byCount:
        final endCount = task.endCondition.count;
        if (endCount != null && task.triggeredCount >= endCount) return null;
        return candidate;
    }
  }
}

/// 便捷的分钟数 <-> TimeOfDay 转换（供数据层与 UI 层复用）。
int timeOfDayToMinutes(TimeOfDay time) => time.hour * 60 + time.minute;

TimeOfDay minutesToTimeOfDay(int minutes) {
  final normalized = minutes % (24 * 60);
  return TimeOfDay(hour: normalized ~/ 60, minute: normalized % 60);
}
