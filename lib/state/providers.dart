import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database/app_database.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/timer_repository.dart';
import '../domain/models/app_settings.dart';
import '../domain/models/timer_task.dart';
import '../platform/notification/notification_service.dart';
import '../platform/sound/sound_service.dart';
import '../platform/startup/startup_service.dart';
import 'scheduler_service.dart';

/// 本地数据库单例。
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final timerRepositoryProvider = Provider<TimerRepository>((ref) {
  return TimerRepository(ref.watch(databaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return const NotificationService();
});

final soundServiceProvider = Provider<SoundService>((ref) {
  final service = SoundService();
  ref.onDispose(service.dispose);
  return service;
});

final startupServiceProvider = Provider<StartupService>((ref) {
  return const StartupService();
});

/// 调度引擎单例：main() 中会在 runApp 之前调用一次 `start()`。
final schedulerServiceProvider = Provider<SchedulerService>((ref) {
  final scheduler = SchedulerService(
    timerRepository: ref.watch(timerRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    notificationService: ref.watch(notificationServiceProvider),
    soundService: ref.watch(soundServiceProvider),
  );
  ref.onDispose(scheduler.dispose);
  return scheduler;
});

/// 定时器列表（按下一次触发时间排序），UI 层直接 watch 此 provider。
final timerListProvider = StreamProvider<List<TimerTask>>((ref) {
  return ref.watch(timerRepositoryProvider).watchAll();
});

/// 应用设置流。
final appSettingsProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watch();
});
