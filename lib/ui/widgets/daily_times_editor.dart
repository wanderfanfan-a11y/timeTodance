import 'package:flutter/material.dart';

import '../utils/date_format_utils.dart';

/// 每日固定时刻多选编辑（可添加/删除多个时刻）。
class DailyTimesEditor extends StatelessWidget {
  final List<TimeOfDay> times;
  final ValueChanged<List<TimeOfDay>> onChanged;

  const DailyTimesEditor({super.key, required this.times, required this.onChanged});

  Future<void> _addTime(BuildContext context) async {
    final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked == null) {
      return;
    }
    if (times.any((t) => t.hour == picked.hour && t.minute == picked.minute)) {
      return;
    }
    final next = List<TimeOfDay>.from(times)..add(picked);
    next.sort((a, b) => (a.hour * 60 + a.minute).compareTo(b.hour * 60 + b.minute));
    onChanged(next);
  }

  void _removeAt(int index) {
    final next = List<TimeOfDay>.from(times)..removeAt(index);
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var i = 0; i < times.length; i++)
          InputChip(
            label: Text(formatTimeOfDay(times[i].hour, times[i].minute)),
            onDeleted: () => _removeAt(i),
          ),
        ActionChip(
          avatar: const Icon(Icons.add, size: 18),
          label: const Text('添加时刻'),
          onPressed: () => _addTime(context),
        ),
      ],
    );
  }
}
