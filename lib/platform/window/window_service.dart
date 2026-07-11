import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

/// 封装 window_manager：窗口初始化、显示/隐藏、拦截关闭按钮。
class WindowService {
  const WindowService();

  static const MethodChannel _channel = MethodChannel('tdance/window');

  Future<void> init() async {
    await windowManager.ensureInitialized();
    const options = WindowOptions(
      size: Size(440, 680),
      minimumSize: Size(380, 480),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      title: 'tdance',
    );
    await windowManager.waitUntilReadyToShow(options, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  /// 是否拦截窗口关闭按钮（拦截后由 [WindowListener.onWindowClose] 决定
  /// 最小化到托盘还是真正退出）。
  Future<void> setPreventClose(bool prevent) => windowManager.setPreventClose(prevent);

  Future<bool> isPreventClose() => windowManager.isPreventClose();

  Future<void> hide() => windowManager.hide();

  Future<bool> isVisible() => windowManager.isVisible();

  Future<void> showAndFocus() async {
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> enterRestOverlay() async {
    if (Platform.isWindows) {
      await _channel.invokeMethod<void>('enterRestMode');
      return;
    }
    await windowManager.setFullScreen(true);
    await windowManager.setAlwaysOnTop(true);
  }

  Future<void> exitRestOverlay() async {
    if (Platform.isWindows) {
      await _channel.invokeMethod<void>('exitRestMode');
      return;
    }
    await windowManager.setAlwaysOnTop(false);
    await windowManager.setFullScreen(false);
  }

  /// 真正退出应用（用于托盘菜单"退出"或设置中选择"直接退出"）。
  Future<void> exitApp() async {
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }
}
