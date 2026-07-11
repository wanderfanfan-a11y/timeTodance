import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_settings.dart';
import '../../domain/models/timer_task.dart';
import '../../state/providers.dart';
import '../utils/date_format_utils.dart';
import '../utils/timer_type_labels.dart';
import '../widgets/daily_times_editor.dart';
import '../widgets/sound_config_editor.dart';
import '../widgets/weekday_selector.dart';

/// 新建/编辑定时器页面（对应 FR-1.1 / FR-1.2 / FR-2.x / FR-3.x）。
class TimerEditPage extends ConsumerStatefulWidget {
  final TimerTask? existing;

  /// 新建时使用的默认提醒方式（来自应用设置，FR-5.3）。
  final AppSettings? defaultSettings;

  const TimerEditPage({super.key, this.existing, this.defaultSettings});

  @override
  ConsumerState<TimerEditPage> createState() => _TimerEditPageState();
}

class _TimerEditPageState extends ConsumerState<TimerEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _messageController;
  late final TextEditingController _countdownHCtrl;
  late final TextEditingController _countdownMCtrl;
  late final TextEditingController _countdownSCtrl;
  late final TextEditingController _intervalHCtrl;
  late final TextEditingController _intervalMCtrl;
  late final TextEditingController _intervalSCtrl;

  late TimerType _type;
  DateTime? _triggerAt;

  List<TimeOfDay> _dailyTimes = [];
  Set<int> _weekdays = {};

  bool _useActiveWindow = false;
  TimeOfDay _activeStart = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _activeEnd = const TimeOfDay(hour: 18, minute: 0);

  bool _useWeekdayFilterForInterval = false;

  EndConditionType _endType = EndConditionType.never;
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  int _endCount = 10;

  bool _notify = true;
  bool _popup = false;
  SoundConfig _sound = const SoundConfig();
  bool _useSnooze = true;
  int _snoozeMinutes = 5;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _nameController = TextEditingController(text: existing?.name ?? '');
    _messageController = TextEditingController(text: existing?.message ?? '');
    _type = existing?.type ?? TimerType.once;
    _triggerAt = existing?.triggerAt ?? DateTime.now().add(const Duration(hours: 1));

    final countdown = existing?.countdownSeconds ?? (25 * 60);
    _countdownHCtrl = TextEditingController(text: '${countdown ~/ 3600}');
    _countdownMCtrl = TextEditingController(text: '${(countdown % 3600) ~/ 60}');
    _countdownSCtrl = TextEditingController(text: '${countdown % 60}');

    final interval = existing?.intervalSeconds ?? (45 * 60);
    _intervalHCtrl = TextEditingController(text: '${interval ~/ 3600}');
    _intervalMCtrl = TextEditingController(text: '${(interval % 3600) ~/ 60}');
    _intervalSCtrl = TextEditingController(text: '${interval % 60}');

    _dailyTimes = List.of(existing?.dailyTimes ?? const []);
    _weekdays = Set.of(existing?.weekdays ?? const []);
    _useWeekdayFilterForInterval = _type == TimerType.interval && _weekdays.isNotEmpty;

    _useActiveWindow = existing?.activeStart != null && existing?.activeEnd != null;
    _activeStart = existing?.activeStart ?? const TimeOfDay(hour: 9, minute: 0);
    _activeEnd = existing?.activeEnd ?? const TimeOfDay(hour: 18, minute: 0);

    _endType = existing?.endCondition.type ?? EndConditionType.never;
    _endDate = existing?.endCondition.date ?? DateTime.now().add(const Duration(days: 30));
    _endCount = existing?.endCondition.count ?? 10;

    final defaults = widget.defaultSettings;
    _notify = existing?.notify ?? defaults?.defaultNotify ?? true;
    _popup = existing?.popup ?? false;
    _sound = existing?.sound ??
        SoundConfig(
          enabled: defaults?.defaultSound ?? true,
          soundId: defaults?.defaultSoundId ?? 'default',
          volume: defaults?.defaultVolume ?? 1.0,
        );
    _snoozeMinutes = existing?.snoozeMinutes ?? 5;
    _useSnooze = (existing?.snoozeMinutes ?? 5) > 0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _messageController.dispose();
    _countdownHCtrl.dispose();
    _countdownMCtrl.dispose();
    _countdownSCtrl.dispose();
    _intervalHCtrl.dispose();
    _intervalMCtrl.dispose();
    _intervalSCtrl.dispose();
    super.dispose();
  }

  int get _countdownSeconds =>
      (int.tryParse(_countdownHCtrl.text) ?? 0) * 3600 +
      (int.tryParse(_countdownMCtrl.text) ?? 0) * 60 +
      (int.tryParse(_countdownSCtrl.text) ?? 0);

  int get _intervalSeconds =>
      (int.tryParse(_intervalHCtrl.text) ?? 0) * 3600 +
      (int.tryParse(_intervalMCtrl.text) ?? 0) * 60 +
      (int.tryParse(_intervalSCtrl.text) ?? 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑定时器' : '新建定时器'),
        actions: [
          if (_isEditing)
            IconButton(icon: const Icon(Icons.delete_outline), tooltip: '删除', onPressed: _delete),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '名称', hintText: '例如：喝水提醒'),
              validator: (value) => (value == null || value.trim().isEmpty) ? '请输入定时器名称' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: '提醒文案（可选）', hintText: '例如：起来喝口水吧'),
              minLines: 1,
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Text('触发类型', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TimerType.values.map((type) {
                return ChoiceChip(
                  label: Text(timerTypeLabel(type)),
                  selected: _type == type,
                  onSelected: (_) => setState(() => _type = type),
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            Text(
              timerTypeDescription(_type),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            const SizedBox(height: 16),
            ..._buildTypeSpecificFields(),
            if (_type != TimerType.once && _type != TimerType.countdown) ...[
              const Divider(height: 32),
              _buildEndConditionSection(),
            ],
            const Divider(height: 32),
            Text('提醒方式', style: Theme.of(context).textTheme.titleSmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('系统通知'),
              value: _notify,
              onChanged: (v) => setState(() => _notify = v),
            ),
            SoundConfigEditor(value: _sound, onChanged: (v) => setState(() => _sound = v)),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('应用内弹窗'),
              subtitle: const Text('应用在前台时，弹出醒目提醒对话框'),
              value: _popup,
              onChanged: (v) => setState(() => _popup = v),
            ),
            if (_popup) ...[
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('稍后提醒（贪睡）'),
                value: _useSnooze,
                onChanged: (v) => setState(() => _useSnooze = v),
              ),
              if (_useSnooze)
                Row(
                  children: [
                    const Text('时长：'),
                    Expanded(
                      child: Slider(
                        min: 1,
                        max: 30,
                        divisions: 29,
                        value: _snoozeMinutes.toDouble(),
                        label: '$_snoozeMinutes 分钟',
                        onChanged: (v) => setState(() => _snoozeMinutes = v.round()),
                      ),
                    ),
                    Text('$_snoozeMinutes 分钟'),
                  ],
                ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _save,
              child: Text(_isEditing ? '保存修改' : '创建定时器'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTypeSpecificFields() {
    switch (_type) {
      case TimerType.once:
        return _buildOnceFields();
      case TimerType.countdown:
        return _buildCountdownFields();
      case TimerType.interval:
        return _buildIntervalFields();
      case TimerType.daily:
        return _buildDailyFields();
      case TimerType.weekly:
        return _buildWeeklyFields();
    }
  }

  List<Widget> _buildOnceFields() {
    final triggerAt = _triggerAt;
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.event_outlined),
        title: const Text('触发时刻'),
        subtitle: Text(triggerAt == null ? '请选择日期与时间' : formatFullDateTime(triggerAt)),
        trailing: const Icon(Icons.chevron_right),
        onTap: _pickTriggerAt,
      ),
    ];
  }

  List<Widget> _buildCountdownFields() {
    return [
      Text('倒计时时长', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 8),
      _buildHmsPicker(hourCtrl: _countdownHCtrl, minuteCtrl: _countdownMCtrl, secondCtrl: _countdownSCtrl),
    ];
  }

  List<Widget> _buildIntervalFields() {
    return [
      Text('间隔时长', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 8),
      _buildHmsPicker(hourCtrl: _intervalHCtrl, minuteCtrl: _intervalMCtrl, secondCtrl: _intervalSCtrl),
      const SizedBox(height: 12),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('限制生效时段'),
        subtitle: const Text('仅在指定时间段内触发，例如仅工作时间'),
        value: _useActiveWindow,
        onChanged: (v) => setState(() => _useActiveWindow = v),
      ),
      if (_useActiveWindow) _buildActiveWindowPickers(),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('限制生效星期'),
        subtitle: const Text('仅在勾选的星期几触发，例如仅工作日'),
        value: _useWeekdayFilterForInterval,
        onChanged: (v) => setState(() => _useWeekdayFilterForInterval = v),
      ),
      if (_useWeekdayFilterForInterval)
        WeekdaySelector(selected: _weekdays, onChanged: (v) => setState(() => _weekdays = v)),
    ];
  }

  List<Widget> _buildDailyFields() {
    return [
      Text('每日固定时刻', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 8),
      DailyTimesEditor(times: _dailyTimes, onChanged: (v) => setState(() => _dailyTimes = v)),
    ];
  }

  List<Widget> _buildWeeklyFields() {
    return [
      Text('触发时刻', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 8),
      DailyTimesEditor(times: _dailyTimes, onChanged: (v) => setState(() => _dailyTimes = v)),
      const SizedBox(height: 16),
      Text('生效星期', style: Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height: 8),
      WeekdaySelector(selected: _weekdays, onChanged: (v) => setState(() => _weekdays = v)),
    ];
  }

  Widget _buildActiveWindowPickers() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('开始'),
              subtitle: Text(formatTimeOfDay(_activeStart.hour, _activeStart.minute)),
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: _activeStart);
                if (picked != null) setState(() => _activeStart = picked);
              },
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('结束'),
              subtitle: Text(formatTimeOfDay(_activeEnd.hour, _activeEnd.minute)),
              onTap: () async {
                final picked = await showTimePicker(context: context, initialTime: _activeEnd);
                if (picked != null) setState(() => _activeEnd = picked);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHmsPicker({
    required TextEditingController hourCtrl,
    required TextEditingController minuteCtrl,
    required TextEditingController secondCtrl,
  }) {
    Widget numberField(String label, TextEditingController controller, int max) {
      return SizedBox(
        width: 88,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(labelText: label),
          keyboardType: TextInputType.number,
          onChanged: (text) {
            final parsed = int.tryParse(text);
            if (parsed == null) return;
            final clamped = parsed.clamp(0, max);
            if (clamped != parsed) {
              final clampedText = '$clamped';
              controller.value = TextEditingValue(
                text: clampedText,
                selection: TextSelection.collapsed(offset: clampedText.length),
              );
            }
          },
        ),
      );
    }

    return Row(
      children: [
        numberField('时', hourCtrl, 999),
        const SizedBox(width: 12),
        numberField('分', minuteCtrl, 59),
        const SizedBox(width: 12),
        numberField('秒', secondCtrl, 59),
      ],
    );
  }

  Widget _buildEndConditionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('结束条件', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: EndConditionType.values.map((type) {
            return ChoiceChip(
              label: Text(endConditionLabel(type)),
              selected: _endType == type,
              onSelected: (_) => setState(() => _endType = type),
            );
          }).toList(),
        ),
        if (_endType == EndConditionType.byDate)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('结束日期'),
            subtitle: Text(formatShortDateTime(_endDate)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: _endDate.isBefore(now) ? now : _endDate,
                firstDate: now,
                lastDate: now.add(const Duration(days: 3650)),
              );
              if (picked != null) setState(() => _endDate = picked);
            },
          ),
        if (_endType == EndConditionType.byCount)
          Row(
            children: [
              const Text('触发次数：'),
              Expanded(
                child: Slider(
                  min: 1,
                  max: 100,
                  divisions: 99,
                  value: _endCount.toDouble().clamp(1, 100),
                  label: '$_endCount 次',
                  onChanged: (v) => setState(() => _endCount = v.round()),
                ),
              ),
              Text('$_endCount 次'),
            ],
          ),
      ],
    );
  }

  Future<void> _pickTriggerAt() async {
    final now = DateTime.now();
    final initialDate = _triggerAt ?? now.add(const Duration(hours: 1));
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(now) ? now : initialDate,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 3650)),
    );
    if (date == null) return;
    if (!mounted) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
    if (time == null) return;
    if (!mounted) return;
    setState(() {
      _triggerAt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  bool _validateTypeSpecific() {
    switch (_type) {
      case TimerType.once:
        if (_triggerAt == null) {
          _showError('请选择触发时刻');
          return false;
        }
        if (!_triggerAt!.isAfter(DateTime.now())) {
          _showError('触发时刻需晚于当前时间');
          return false;
        }
        return true;
      case TimerType.countdown:
        if (_countdownSeconds <= 0) {
          _showError('请设置倒计时时长');
          return false;
        }
        return true;
      case TimerType.interval:
        if (_intervalSeconds <= 0) {
          _showError('请设置间隔时长');
          return false;
        }
        return true;
      case TimerType.daily:
        if (_dailyTimes.isEmpty) {
          _showError('请添加至少一个每日固定时刻');
          return false;
        }
        return true;
      case TimerType.weekly:
        if (_dailyTimes.isEmpty) {
          _showError('请添加至少一个触发时刻');
          return false;
        }
        if (_weekdays.isEmpty) {
          _showError('请选择至少一个生效星期');
          return false;
        }
        return true;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_validateTypeSpecific()) return;

    final now = DateTime.now();
    final base = widget.existing;
    final effectiveWeekdays = switch (_type) {
      TimerType.interval => _useWeekdayFilterForInterval ? _weekdays.toList() : <int>[],
      TimerType.weekly => _weekdays.toList(),
      _ => <int>[],
    };

    final task = TimerTask(
      id: base?.id ?? '',
      name: _nameController.text.trim(),
      message: _messageController.text.trim(),
      type: _type,
      enabled: base?.enabled ?? true,
      triggerAt: _type == TimerType.once ? _triggerAt : null,
      countdownSeconds: _type == TimerType.countdown ? _countdownSeconds : null,
      intervalSeconds: _type == TimerType.interval ? _intervalSeconds : null,
      dailyTimes: (_type == TimerType.daily || _type == TimerType.weekly) ? _dailyTimes : const [],
      weekdays: effectiveWeekdays,
      activeStart: (_type == TimerType.interval && _useActiveWindow) ? _activeStart : null,
      activeEnd: (_type == TimerType.interval && _useActiveWindow) ? _activeEnd : null,
      endCondition: switch (_endType) {
        EndConditionType.never => const EndCondition.never(),
        EndConditionType.byDate => EndCondition.byDate(_endDate),
        EndConditionType.byCount => EndCondition.byCount(_endCount),
      },
      triggeredCount: base?.triggeredCount ?? 0,
      sound: _sound,
      notify: _notify,
      popup: _popup,
      snoozeMinutes: _useSnooze ? _snoozeMinutes : null,
      lastTriggeredAt: base?.lastTriggeredAt,
      nextTriggerAt: base?.nextTriggerAt,
      createdAt: base?.createdAt ?? now,
      updatedAt: now,
    );

    final repo = ref.read(timerRepositoryProvider);
    if (_isEditing) {
      await repo.update(task);
    } else {
      await repo.create(task);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _delete() async {
    final base = widget.existing;
    if (base == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除定时器'),
        content: Text('确定要删除"${base.name}"吗？此操作不可恢复。'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('删除')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(timerRepositoryProvider).delete(base.id);
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }
}
