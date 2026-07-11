import 'package:local_notifier/local_notifier.dart';

/// 封装 local_notifier：Windows 系统通知（标题 + 正文）。
class NotificationService {
  const NotificationService();

  Future<void> init({required String appName}) async {
    await localNotifier.setup(
      appName: appName,
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  Future<void> show({required String title, required String body}) async {
    final notification = LocalNotification(title: title, body: body);
    await notification.show();
  }
}
