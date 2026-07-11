import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/app_keys.dart';
import 'state/providers.dart';
import 'state/scheduler_service.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/rest_overlay.dart';
import 'ui/theme/app_theme.dart';
import 'ui/widgets/reminder_dialog.dart';

/// 应用根组件：负责主题/本地化、监听调度引擎的弹窗提醒事件，
/// 以及拦截窗口关闭按钮（最小化到托盘 vs 直接退出，FR-4.1 / FR-5.2）。
class TDanceApp extends ConsumerStatefulWidget {
  const TDanceApp({super.key});

  @override
  ConsumerState<TDanceApp> createState() => _TDanceAppState();
}

class _TDanceAppState extends ConsumerState<TDanceApp> with WindowListener {
  StreamSubscription<ReminderEvent>? _reminderSub;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _reminderSub = ref.read(schedulerServiceProvider).reminders.listen(_showReminderDialog);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    _reminderSub?.cancel();
    super.dispose();
  }

  @override
  void onWindowClose() async {
    final isPreventClose = await windowManager.isPreventClose();
    if (!isPreventClose) return;
    final settings = await ref.read(settingsRepositoryProvider).load();
    if (settings.minimizeToTrayOnClose) {
      await windowManager.hide();
    } else {
      await windowManager.setPreventClose(false);
      await windowManager.close();
    }
  }

  void _showReminderDialog(ReminderEvent event) {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;
    showDialog(context: context, builder: (_) => ReminderDialog(task: event.task));
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(appSettingsProvider);
    final themeMode = settingsAsync.maybeWhen(data: (s) => s.themeMode, orElse: () => ThemeMode.system);

    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      title: 'tdance',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      locale: const Locale('zh', 'CN'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN')],
      home: const HomePage(),
      builder: (context, child) {
        final service = ref.read(restModeServiceProvider);
        return ValueListenableBuilder(
          valueListenable: service.session,
          child: child,
          builder: (context, session, child) {
            if (session == null) return child ?? const SizedBox.shrink();
            return RestOverlay(
              key: ValueKey(session.endsAt),
              session: session,
              service: service,
            );
          },
        );
      },
    );
  }
}
