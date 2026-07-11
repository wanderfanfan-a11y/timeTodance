import 'dart:io';

import 'package:path/path.dart' as p;

/// 解析 Flutter asset 在打包后于文件系统中的真实路径（Windows 桌面）。
///
/// Windows 桌面构建（debug/release）都会把 assets 复制到可执行文件同级的
/// `data/flutter_assets/` 目录下。像 tray_manager 设置托盘图标这样需要
/// "真实文件路径"而非 Flutter asset bundle key 的场景，需要用到这个路径。
String resolveDesktopAssetPath(String assetKey) {
  final exeDir = File(Platform.resolvedExecutable).parent.path;
  return p.join(exeDir, 'data', 'flutter_assets', assetKey);
}
