import 'dart:io';

import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 封装 launch_at_startup：开机自启开关。
class StartupService {
  const StartupService();

  Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
      packageName: 'com.timetodance.tdance',
    );
  }

  Future<bool> isEnabled() => launchAtStartup.isEnabled();

  Future<void> setEnabled(bool enabled) async {
    if (enabled) {
      await launchAtStartup.enable();
    } else {
      await launchAtStartup.disable();
    }
  }
}
