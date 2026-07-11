import 'dart:async';

import '../data/repositories/settings_repository.dart';
import '../data/repositories/timer_repository.dart';
import '../domain/models/app_settings.dart';
import '../domain/models/timer_task.dart';
import '../domain/schedule/schedule_calculator.dart';
import '../platform/notification/notification_service.dart';
import '../platform/rest/rest_mode_service.dart';
import '../platform/sound/sound_service.dart';

/// 提醒到点时的事件载荷，交给 UI 层决定是否弹窗展示（应用内弹窗，FR-3.4）。
class ReminderEvent {
  final TimerTask task;

  const ReminderEvent(this.task);
}

/// 定时器运行时调度引擎（对应需求文档 8.3 调度引擎设计要点）。
///
/// 采用"计算下一次触发时间 + 定时唤醒"模型：领域层 [ScheduleCalculator]
/// 负责纯计算，本类负责把结果转换为真实的 [Timer] 唤醒动作，并在到点时
/// 分发提醒（系统通知 / 声音 / 应用内弹窗），再持久化下一次触发时间。
class SchedulerService {
  final TimerRepository timerRepository;
  final SettingsRepository settingsRepository;
  final NotificationService notificationService;
  final SoundService soundService;
  final RestModeService restModeService;
  final ScheduleCalculator _calculator = const ScheduleCalculator();
  static const Duration _deliveryGracePeriod = Duration(seconds: 2);

  final Map<String, Timer> _timers = {};
  final Map<String, Timer> _snoozeTimers = {};
  AppSettings _settings = const AppSettings();
  bool _globallyPaused = false;

  StreamSubscription<List<TimerTask>>? _taskSub;
  StreamSubscription<AppSettings>? _settingsSub;

  final StreamController<ReminderEvent> _reminderController = StreamController.broadcast();

  /// UI 层订阅此流，在弹窗提醒开启时展示"知道了/稍后提醒"对话框。
  Stream<ReminderEvent> get reminders => _reminderController.stream;

  SchedulerService({
    required this.timerRepository,
    required this.settingsRepository,
    required this.notificationService,
    required this.soundService,
    required this.restModeService,
  });

  /// 启动调度引擎：重新计算所有定时器的下一次触发时间（不补发错过的提醒），
  /// 然后开始监听数据变化并排程。对应 FR-6.2 / FR-2.8 / 已确认决策#4。
  Future<void> start() async {
    _settings = await settingsRepository.load();
    _settingsSub = settingsRepository.watch().listen((s) => _settings = s);

    final tasks = await timerRepository.loadAll();
    final now = DateTime.now();
    for (final task in tasks) {
      final recomputed = _calculator.computeNextTrigger(task, now);
      if (recomputed != task.nextTriggerAt) {
        await timerRepository.updateNextTrigger(task.id, recomputed);
      }
    }

    _taskSub = timerRepository.watchAll().listen(_reconcile);
  }

  Future<void> dispose() async {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    for (final timer in _snoozeTimers.values) {
      timer.cancel();
    }
    _timers.clear();
    _snoozeTimers.clear();
    await _taskSub?.cancel();
    await _settingsSub?.cancel();
    await _reminderController.close();
  }

  void _reconcile(List<TimerTask> tasks) {
    final activeIds = <String>{};
    for (final task in tasks) {
      activeIds.add(task.id);
      _scheduleTask(task);
    }
    final removed = _timers.keys.where((id) => !activeIds.contains(id)).toList();
    for (final id in removed) {
      _timers.remove(id)?.cancel();
    }
  }

  void _scheduleTask(TimerTask task) {
    _timers.remove(task.id)?.cancel();
    if (_globallyPaused || !task.enabled || task.nextTriggerAt == null) return;
    final delay = task.nextTriggerAt!.difference(DateTime.now());
    final safeDelay = delay.isNegative ? Duration.zero : delay;
    _timers[task.id] = Timer(safeDelay, () => _fire(task.id));
  }

  Future<void> _fire(String taskId) async {
    final task = await timerRepository.findById(taskId);
    if (task == null || !task.enabled) return;

    final now = DateTime.now();
    final scheduledAt = task.nextTriggerAt;
    if (scheduledAt == null) return;
    if (now.difference(scheduledAt) > _deliveryGracePeriod) {
      final nextTrigger = _calculator.computeNextTrigger(task, now);
      await timerRepository.updateNextTrigger(taskId, nextTrigger);
      return;
    }

    final suppressedByDnd = _settings.isInDnd(now);
    final taskAfterTrigger = suppressedByDnd
        ? task
        : task.copyWith(triggeredCount: task.triggeredCount + 1);
    final nextTrigger = _calculator.computeNextTrigger(
      taskAfterTrigger,
      now,
    );

    if (suppressedByDnd) {
      // 勿扰时段：完全不提醒（不通知/不发声/不弹窗），仅静默前进到下一次。
      await timerRepository.updateNextTrigger(taskId, nextTrigger);
    } else {
      await timerRepository.markTriggered(taskId, triggeredAt: now, nextTriggerAt: nextTrigger);
      await _deliver(task);
    }
  }

  Future<void> _deliver(TimerTask task) async {
    if (task.forceRest) {
      await notificationService.show(
        title: '强制休息将在 10 秒后开始',
        body: task.message.isEmpty ? task.name : task.message,
      );
      if (task.sound.enabled) {
        await soundService.play(soundId: task.sound.soundId, volume: task.sound.volume);
      }
      await Future<void>.delayed(const Duration(seconds: 10));
      await restModeService.start(task);
      return;
    }

    if (task.notify) {
      await notificationService.show(
        title: task.name,
        body: task.message.isEmpty ? '时间到了' : task.message,
      );
    }
    if (task.sound.enabled) {
      await soundService.play(soundId: task.sound.soundId, volume: task.sound.volume);
    }
    if (task.popup) {
      _reminderController.add(ReminderEvent(task));
    }
  }

  /// 贪睡/再响（FR-3.5）：不影响主调度计划与 triggeredCount，
  /// [duration] 后再次投递一次提醒。
  void snooze(TimerTask task, Duration duration) {
    _snoozeTimers.remove(task.id)?.cancel();
    _snoozeTimers[task.id] = Timer(duration, () => _deliver(task));
  }

  /// 托盘菜单"全部暂停/恢复"（FR-4.2）。
  Future<void> pauseAll() async {
    _globallyPaused = true;
    for (final timer in _timers.values) {
      timer.cancel();
    }
    for (final timer in _snoozeTimers.values) {
      timer.cancel();
    }
    _timers.clear();
    _snoozeTimers.clear();
  }

  Future<void> resumeAll() async {
    _globallyPaused = false;
    final tasks = await timerRepository.loadAll();
    final now = DateTime.now();
    for (final task in tasks) {
      if (!task.enabled) continue;
      final nextTrigger = _calculator.computeNextTrigger(task, now);
      if (nextTrigger != task.nextTriggerAt) {
        await timerRepository.updateNextTrigger(task.id, nextTrigger);
      }
    }
    _reconcile(await timerRepository.loadAll());
  }
}
