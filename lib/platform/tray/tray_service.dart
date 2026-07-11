import 'dart:io';

import 'package:tray_manager/tray_manager.dart';

import '../../core/asset_path.dart';

/// 封装 tray_manager：托盘图标、右键菜单（显示主界面/快速新建/全部暂停或恢复/退出）。
class TrayService with TrayListener {
  final Future<void> Function() onShowWindow;
  final Future<void> Function() onQuickAdd;
  final Future<void> Function() onPauseAll;
  final Future<void> Function() onResumeAll;
  final Future<void> Function() onExit;
  bool _allPaused = false;

  TrayService({
    required this.onShowWindow,
    required this.onQuickAdd,
    required this.onPauseAll,
    required this.onResumeAll,
    required this.onExit,
  });

  Future<void> init() async {
    trayManager.addListener(this);
    final iconPath = Platform.isWindows
        ? resolveDesktopAssetPath('windows/runner/resources/app_icon.ico')
        : resolveDesktopAssetPath('assets/icon/icon.png');
    await trayManager.setIcon(iconPath);
    await trayManager.setToolTip('tdance 定时提醒');
    await _rebuildMenu();
  }

  Future<void> _rebuildMenu() async {
    final menu = Menu(
      items: [
        MenuItem(key: 'show_window', label: '显示主界面'),
        MenuItem(key: 'quick_add', label: '快速新建'),
        MenuItem(key: 'toggle_pause_all', label: _allPaused ? '全部恢复' : '全部暂停'),
        MenuItem.separator(),
        MenuItem(key: 'exit_app', label: '退出'),
      ],
    );
    await trayManager.setContextMenu(menu);
  }

  void dispose() {
    trayManager.removeListener(this);
  }

  @override
  void onTrayIconMouseDown() {
    onShowWindow();
  }

  @override
  void onTrayIconRightMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'show_window':
        onShowWindow();
        break;
      case 'quick_add':
        onQuickAdd();
        break;
      case 'toggle_pause_all':
        _togglePauseAll();
        break;
      case 'exit_app':
        onExit();
        break;
    }
  }

  Future<void> _togglePauseAll() async {
    if (_allPaused) {
      await onResumeAll();
    } else {
      await onPauseAll();
    }
    _allPaused = !_allPaused;
    await _rebuildMenu();
  }
}
