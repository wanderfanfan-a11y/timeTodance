import 'package:flutter/material.dart' show TimeOfDay;

/// 定时器类型
enum TimerType {
  /// 一次性·指定时刻
  once,

  /// 一次性·倒计时
  countdown,

  /// 周期性·固定间隔
  interval,

  /// 周期性·每日固定时刻
  daily,

  /// 周期性·按星期
  weekly,
}

/// 周期性结束条件类型
enum EndConditionType {
  /// 永不结束
  never,

  /// 到某日期后结束
  byDate,

  /// 触发 N 次后停止
  byCount,
}

/// 周期性定时器的结束条件
class EndCondition {
  final EndConditionType type;
  final DateTime? date;
  final int? count;

  const EndCondition._(this.type, this.date, this.count);

  const EndCondition.never() : this._(EndConditionType.never, null, null);

  const EndCondition.byDate(DateTime date) : this._(EndConditionType.byDate, date, null);

  const EndCondition.byCount(int count) : this._(EndConditionType.byCount, null, count);

  EndCondition copyWith({EndConditionType? type, DateTime? date, int? count}) {
    return EndCondition._(type ?? this.type, date ?? this.date, count ?? this.count);
  }

  @override
  bool operator ==(Object other) {
    return other is EndCondition && other.type == type && other.date == date && other.count == count;
  }

  @override
  int get hashCode => Object.hash(type, date, count);
}

/// 声音提醒配置
class SoundConfig {
  final bool enabled;
  final String soundId;
  final double volume;

  const SoundConfig({this.enabled = true, this.soundId = 'default', this.volume = 1.0});

  SoundConfig copyWith({bool? enabled, String? soundId, double? volume}) {
    return SoundConfig(
      enabled: enabled ?? this.enabled,
      soundId: soundId ?? this.soundId,
      volume: volume ?? this.volume,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SoundConfig && other.enabled == enabled && other.soundId == soundId && other.volume == volume;
  }

  @override
  int get hashCode => Object.hash(enabled, soundId, volume);
}

/// 定时器任务领域模型（纯 Dart，与数据层/平台层解耦）
class TimerTask {
  final String id;
  final String name;
  final String message;
  final TimerType type;
  final bool enabled;

  /// 一次性·指定时刻
  final DateTime? triggerAt;

  /// 一次性·倒计时（秒）
  final int? countdownSeconds;

  /// 周期性·固定间隔（秒）
  final int? intervalSeconds;

  /// 周期性·每日固定时刻（可多个）
  final List<TimeOfDay> dailyTimes;

  /// 生效星期（1=周一 .. 7=周日），为空表示不限制
  final List<int> weekdays;

  /// 生效时段限制（仅 interval 类型生效）
  final TimeOfDay? activeStart;
  final TimeOfDay? activeEnd;

  final EndCondition endCondition;

  /// 已触发次数（用于 byCount 结束条件）
  final int triggeredCount;

  final SoundConfig sound;
  final bool notify;
  final bool popup;
  final int? snoozeMinutes;
  final bool forceRest;
  final int restDurationMinutes;

  final DateTime? lastTriggeredAt;
  final DateTime? nextTriggerAt;

  final DateTime createdAt;
  final DateTime updatedAt;

  const TimerTask({
    required this.id,
    required this.name,
    this.message = '',
    required this.type,
    this.enabled = true,
    this.triggerAt,
    this.countdownSeconds,
    this.intervalSeconds,
    this.dailyTimes = const [],
    this.weekdays = const [],
    this.activeStart,
    this.activeEnd,
    this.endCondition = const EndCondition.never(),
    this.triggeredCount = 0,
    this.sound = const SoundConfig(),
    this.notify = true,
    this.popup = false,
    this.snoozeMinutes = 5,
    this.forceRest = false,
    this.restDurationMinutes = 5,
    this.lastTriggeredAt,
    this.nextTriggerAt,
    required this.createdAt,
    required this.updatedAt,
  });

  TimerTask copyWith({
    String? id,
    String? name,
    String? message,
    TimerType? type,
    bool? enabled,
    DateTime? triggerAt,
    bool clearTriggerAt = false,
    int? countdownSeconds,
    bool clearCountdownSeconds = false,
    int? intervalSeconds,
    bool clearIntervalSeconds = false,
    List<TimeOfDay>? dailyTimes,
    List<int>? weekdays,
    TimeOfDay? activeStart,
    bool clearActiveStart = false,
    TimeOfDay? activeEnd,
    bool clearActiveEnd = false,
    EndCondition? endCondition,
    int? triggeredCount,
    SoundConfig? sound,
    bool? notify,
    bool? popup,
    int? snoozeMinutes,
    bool? forceRest,
    int? restDurationMinutes,
    DateTime? lastTriggeredAt,
    bool clearLastTriggeredAt = false,
    DateTime? nextTriggerAt,
    bool clearNextTriggerAt = false,
    DateTime? updatedAt,
  }) {
    return TimerTask(
      id: id ?? this.id,
      name: name ?? this.name,
      message: message ?? this.message,
      type: type ?? this.type,
      enabled: enabled ?? this.enabled,
      triggerAt: clearTriggerAt ? null : (triggerAt ?? this.triggerAt),
      countdownSeconds: clearCountdownSeconds ? null : (countdownSeconds ?? this.countdownSeconds),
      intervalSeconds: clearIntervalSeconds ? null : (intervalSeconds ?? this.intervalSeconds),
      dailyTimes: dailyTimes ?? this.dailyTimes,
      weekdays: weekdays ?? this.weekdays,
      activeStart: clearActiveStart ? null : (activeStart ?? this.activeStart),
      activeEnd: clearActiveEnd ? null : (activeEnd ?? this.activeEnd),
      endCondition: endCondition ?? this.endCondition,
      triggeredCount: triggeredCount ?? this.triggeredCount,
      sound: sound ?? this.sound,
      notify: notify ?? this.notify,
      popup: popup ?? this.popup,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      forceRest: forceRest ?? this.forceRest,
      restDurationMinutes: restDurationMinutes ?? this.restDurationMinutes,
      lastTriggeredAt: clearLastTriggeredAt ? null : (lastTriggeredAt ?? this.lastTriggeredAt),
      nextTriggerAt: clearNextTriggerAt ? null : (nextTriggerAt ?? this.nextTriggerAt),
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
