import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/models/timer_task.dart';
import '../../state/providers.dart';
import '../utils/date_format_utils.dart';
import '../widgets/sound_config_editor.dart';

/// 应用设置页面（对应 FR-5.x）。
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
      body: settingsAsync.when(
        data: (settings) => _SettingsBody(settings: settings),
        error: (error, stack) => Center(child: Text('加载失败：$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SettingsBody extends ConsumerStatefulWidget {
  final AppSettings settings;

  const _SettingsBody({required this.settings});

  @override
  ConsumerState<_SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends ConsumerState<_SettingsBody> {
  bool? _actualStartupEnabled;

  @override
  void initState() {
    super.initState();
    _syncStartupState();
  }

  Future<void> _syncStartupState() async {
    final enabled = await ref.read(startupServiceProvider).isEnabled();
    if (mounted) {
      setState(() => _actualStartupEnabled = enabled);
    }
  }

  Future<void> _update(AppSettings Function(AppSettings current) updater) async {
    final repo = ref.read(settingsRepositoryProvider);
    await repo.save(updater(widget.settings));
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('系统集成', style: theme.textTheme.titleSmall),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('开机自启'),
          value: _actualStartupEnabled ?? settings.startOnLogin,
          onChanged: (v) async {
            await ref.read(startupServiceProvider).setEnabled(v);
            await _update((s) => s.copyWith(startOnLogin: v));
            await _syncStartupState();
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('关闭按钮最小化到托盘'),
          subtitle: const Text('关闭窗口时隐藏到系统托盘，而不是直接退出应用'),
          value: settings.minimizeToTrayOnClose,
          onChanged: (v) => _update((s) => s.copyWith(minimizeToTrayOnClose: v)),
        ),
        const Divider(height: 32),
        Text('默认提醒方式', style: theme.textTheme.titleSmall),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('默认系统通知'),
          value: settings.defaultNotify,
          onChanged: (v) => _update((s) => s.copyWith(defaultNotify: v)),
        ),
        SoundConfigEditor(
          value: SoundConfig(
            enabled: settings.defaultSound,
            soundId: settings.defaultSoundId,
            volume: settings.defaultVolume,
          ),
          onChanged: (v) => _update(
            (s) => s.copyWith(defaultSound: v.enabled, defaultSoundId: v.soundId, defaultVolume: v.volume),
          ),
        ),
        const Divider(height: 32),
        Text('勿扰时段', style: theme.textTheme.titleSmall),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('启用勿扰时段'),
          subtitle: const Text('勿扰期间完全不提醒（不通知、不发声、不弹窗）'),
          value: settings.dndEnabled,
          onChanged: (v) => _update((s) => s.copyWith(dndEnabled: v)),
        ),
        if (settings.dndEnabled)
          Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('开始'),
                  subtitle: Text(
                    settings.dndStart == null
                        ? '未设置'
                        : formatTimeOfDay(settings.dndStart!.hour, settings.dndStart!.minute),
                  ),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: settings.dndStart ?? const TimeOfDay(hour: 22, minute: 0),
                    );
                    if (picked != null) {
                      await _update((s) => s.copyWith(dndStart: picked));
                    }
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('结束'),
                  subtitle: Text(
                    settings.dndEnd == null ? '未设置' : formatTimeOfDay(settings.dndEnd!.hour, settings.dndEnd!.minute),
                  ),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: settings.dndEnd ?? const TimeOfDay(hour: 7, minute: 0),
                    );
                    if (picked != null) {
                      await _update((s) => s.copyWith(dndEnd: picked));
                    }
                  },
                ),
              ),
            ],
          ),
        const Divider(height: 32),
        Text('外观', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(value: ThemeMode.system, label: Text('跟随系统'), icon: Icon(Icons.brightness_auto_outlined)),
            ButtonSegment(value: ThemeMode.light, label: Text('浅色'), icon: Icon(Icons.light_mode_outlined)),
            ButtonSegment(value: ThemeMode.dark, label: Text('深色'), icon: Icon(Icons.dark_mode_outlined)),
          ],
          selected: {settings.themeMode},
          onSelectionChanged: (selection) => _update((s) => s.copyWith(themeMode: selection.first)),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
