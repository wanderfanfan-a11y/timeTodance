import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/timer_task.dart';
import '../../state/providers.dart';

/// 应用在前台时弹出的醒目提醒对话框（FR-3.4 / FR-3.5）。
class ReminderDialog extends ConsumerWidget {
  final TimerTask task;

  const ReminderDialog({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snoozeMinutes = task.snoozeMinutes;
    return AlertDialog(
      icon: const Icon(Icons.notifications_active),
      title: Text(task.name),
      content: Text(task.message.isEmpty ? '时间到了' : task.message),
      actions: [
        if (snoozeMinutes != null && snoozeMinutes > 0)
          TextButton(
            onPressed: () {
              ref.read(schedulerServiceProvider).snooze(task, Duration(minutes: snoozeMinutes));
              Navigator.of(context).pop();
            },
            child: Text('稍后提醒（$snoozeMinutes 分钟）'),
          ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('知道了'),
        ),
      ],
    );
  }
}
