import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as p;

/// 内置铃声选项：直接复用 Windows 系统自带的媒体音效文件（`%SystemRoot%\Media`），
/// 无需在应用内额外打包音频资源，即可实现"可选内置铃声"。
class RingtoneOption {
  final String id;
  final String label;
  final String fileName;

  const RingtoneOption({required this.id, required this.label, required this.fileName});

  String get absolutePath {
    final root = Platform.environment['SystemRoot'] ?? r'C:\Windows';
    return p.join(root, 'Media', fileName);
  }

  bool get exists => File(absolutePath).existsSync();
}

const List<RingtoneOption> kBuiltInRingtones = [
  RingtoneOption(id: 'default', label: '系统默认', fileName: 'Windows Notify.wav'),
  RingtoneOption(id: 'ding', label: '提示音', fileName: 'Windows Ding.wav'),
  RingtoneOption(id: 'exclamation', label: '感叹', fileName: 'Windows Exclamation.wav'),
  RingtoneOption(id: 'alarm', label: '闹钟', fileName: 'Alarm01.wav'),
  RingtoneOption(id: 'ring', label: '铃声', fileName: 'Ring01.wav'),
  RingtoneOption(id: 'notify_generic', label: '通知（通用）', fileName: 'Windows Notify System Generic.wav'),
];

RingtoneOption ringtoneById(String id) {
  return kBuiltInRingtones.firstWhere((r) => r.id == id, orElse: () => kBuiltInRingtones.first);
}

/// 封装 audioplayers：播放内置铃声、音量控制。
class SoundService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play({required String soundId, required double volume}) async {
    final requested = ringtoneById(soundId);
    RingtoneOption? target = requested.exists ? requested : null;
    if (target == null) {
      for (final option in kBuiltInRingtones) {
        if (option.exists) {
          target = option;
          break;
        }
      }
    }
    if (target == null) return; // 系统媒体文件缺失时静默跳过，不影响通知/弹窗提醒。
    await _player.stop();
    await _player.setVolume(volume.clamp(0.0, 1.0));
    await _player.play(DeviceFileSource(target.absolutePath));
  }

  Future<void> stop() => _player.stop();

  void dispose() {
    _player.dispose();
  }
}
