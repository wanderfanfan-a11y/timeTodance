import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/app_keys.dart';
import 'core/single_instance.dart';
import 'platform/tray/tray_service.dart';
import 'platform/window/window_service.dart';
import 'state/providers.dart';
import 'ui/pages/timer_edit_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const windowService = WindowService();
  final instanceGuard = SingleInstanceGuard();
  final isPrimaryInstance = await instanceGuard.acquire(
    onActivateRequested: windowService.showAndFocus,
  );
  if (!isPrimaryInstance) {
    exit(0);
  }

  await windowService.init();
  await windowService.setPreventClose(true);

  final container = ProviderContainer();
  await container.read(notificationServiceProvider).init(appName: 'tdance');
  await container.read(startupServiceProvider).init();
  final restModeService = container.read(restModeServiceProvider);
  await restModeService.initialize();
  await container.read(schedulerServiceProvider).start();

  late final TrayService trayService;
  trayService = TrayService(
    onShowWindow: windowService.showAndFocus,
    onQuickAdd: () async {
      if (restModeService.isActive) return;
      await windowService.showAndFocus();
      final navigator = rootNavigatorKey.currentState;
      if (navigator == null) return;
      final settings = await container.read(settingsRepositoryProvider).load();
      await navigator.push(
        MaterialPageRoute<void>(
          builder: (_) => TimerEditPage(defaultSettings: settings),
        ),
      );
    },
    onPauseAll: container.read(schedulerServiceProvider).pauseAll,
    onResumeAll: container.read(schedulerServiceProvider).resumeAll,
    onExit: () async {
      if (restModeService.isActive) return;
      trayService.dispose();
      await instanceGuard.release();
      container.dispose();
      await windowService.exitApp();
    },
  );
  await trayService.init();

  runApp(
    UncontrolledProviderScope(container: container, child: const TDanceApp()),
  );
}

typedef MyApp = TDanceApp;
