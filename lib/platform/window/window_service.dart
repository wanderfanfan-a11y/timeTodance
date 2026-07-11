import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/// 封装 window_manager：窗口初始化、显示/隐藏、拦截关闭按钮。
class WindowService {
  const WindowService();

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

  /// 真正退出应用（用于托盘菜单"退出"或设置中选择"直接退出"）。
  Future<void> exitApp() async {
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }
}
