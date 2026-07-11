import 'package:flutter/material.dart' show TimeOfDay, ThemeMode;

/// 应用设置领域模型
class AppSettings {
  /// 开机自启
  final bool startOnLogin;

  /// 关闭按钮：true = 最小化到托盘，false = 直接退出
  final bool minimizeToTrayOnClose;

  /// 默认是否系统通知
  final bool defaultNotify;

  /// 默认是否播放声音
  final bool defaultSound;

  /// 默认音量 0.0-1.0
  final double defaultVolume;

  /// 默认铃声
  final String defaultSoundId;

  /// 勿扰时段开关
  final bool dndEnabled;

  /// 勿扰起止时间
  final TimeOfDay? dndStart;
  final TimeOfDay? dndEnd;

  /// 主题
  final ThemeMode themeMode;

  const AppSettings({
    this.startOnLogin = false,
    this.minimizeToTrayOnClose = true,
    this.defaultNotify = true,
    this.defaultSound = true,
    this.defaultVolume = 1.0,
    this.defaultSoundId = 'default',
    this.dndEnabled = false,
    this.dndStart,
    this.dndEnd,
    this.themeMode = ThemeMode.system,
  });

  AppSettings copyWith({
    bool? startOnLogin,
    bool? minimizeToTrayOnClose,
    bool? defaultNotify,
    bool? defaultSound,
    double? defaultVolume,
    String? defaultSoundId,
    bool? dndEnabled,
    TimeOfDay? dndStart,
    bool clearDndStart = false,
    TimeOfDay? dndEnd,
    bool clearDndEnd = false,
    ThemeMode? themeMode,
  }) {
    return AppSettings(
      startOnLogin: startOnLogin ?? this.startOnLogin,
      minimizeToTrayOnClose: minimizeToTrayOnClose ?? this.minimizeToTrayOnClose,
      defaultNotify: defaultNotify ?? this.defaultNotify,
      defaultSound: defaultSound ?? this.defaultSound,
      defaultVolume: defaultVolume ?? this.defaultVolume,
      defaultSoundId: defaultSoundId ?? this.defaultSoundId,
      dndEnabled: dndEnabled ?? this.dndEnabled,
      dndStart: clearDndStart ? null : (dndStart ?? this.dndStart),
      dndEnd: clearDndEnd ? null : (dndEnd ?? this.dndEnd),
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// 判断给定时刻是否处于勿扰时段内
  bool isInDnd(DateTime at) {
    if (!dndEnabled || dndStart == null || dndEnd == null) return false;
    final nowMinutes = at.hour * 60 + at.minute;
    final startMinutes = dndStart!.hour * 60 + dndStart!.minute;
    final endMinutes = dndEnd!.hour * 60 + dndEnd!.minute;
    if (startMinutes == endMinutes) return false;
    if (startMinutes < endMinutes) {
      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    }
    // 跨越午夜的时段，例如 22:00 - 07:00
    return nowMinutes >= startMinutes || nowMinutes < endMinutes;
  }
}
