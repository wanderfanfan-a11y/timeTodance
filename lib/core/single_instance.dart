import 'dart:io';

/// 基于本机 TCP 端口的单实例守护（Windows 桌面）。
///
/// - 端口绑定成功 => 当前是第一个实例，继续正常启动，并监听后续实例发来的
///   "唤醒"信号（用于把已存在的窗口带到前台）。
/// - 端口绑定失败 => 已有实例在运行，向其发送一次唤醒信号后应立即退出，
///   不再继续构建 UI（对应 FR-4.7 单实例运行）。
class SingleInstanceGuard {
  static const int _port = 58642;

  ServerSocket? _server;

  /// 尝试成为主实例。返回 true 表示当前进程应继续启动；
  /// 返回 false 表示已有实例运行，调用方应立即退出当前进程。
  Future<bool> acquire({required Future<void> Function() onActivateRequested}) async {
    try {
      _server = await ServerSocket.bind(InternetAddress.loopbackIPv4, _port);
      _server!.listen((socket) {
        socket.close();
        onActivateRequested();
      });
      return true;
    } on SocketException {
      try {
        final socket = await Socket.connect(
          InternetAddress.loopbackIPv4,
          _port,
          timeout: const Duration(seconds: 1),
        );
        await socket.close();
      } catch (_) {
        // 即使唤醒信号发送失败，也不应重复启动一个新实例。
      }
      return false;
    }
  }

  Future<void> release() async {
    await _server?.close();
    _server = null;
  }
}
