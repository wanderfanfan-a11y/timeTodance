import 'package:flutter/material.dart';

import '../../domain/models/timer_task.dart';
import '../../platform/sound/sound_service.dart';

/// 单个定时器的声音提醒配置（开关 / 铃声 / 音量），对应 FR-3.3 / FR-3.7。
class SoundConfigEditor extends StatelessWidget {
  final SoundConfig value;
  final ValueChanged<SoundConfig> onChanged;

  const SoundConfigEditor({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('声音提醒'),
          value: value.enabled,
          onChanged: (v) => onChanged(value.copyWith(enabled: v)),
        ),
        if (value.enabled) ...[
          DropdownButtonFormField<String>(
            initialValue: value.soundId,
            decoration: const InputDecoration(labelText: '铃声'),
            items: [
              for (final ringtone in kBuiltInRingtones)
                DropdownMenuItem(value: ringtone.id, child: Text(ringtone.label)),
            ],
            onChanged: (v) {
              if (v != null) onChanged(value.copyWith(soundId: v));
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.volume_down),
              Expanded(
                child: Slider(
                  value: value.volume.clamp(0.0, 1.0),
                  onChanged: (v) => onChanged(value.copyWith(volume: v)),
                ),
              ),
              const Icon(Icons.volume_up),
            ],
          ),
        ],
      ],
    );
  }
}
