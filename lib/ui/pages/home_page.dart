import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/timer_task.dart';
import '../../state/providers.dart';
import '../widgets/timer_card.dart';
import 'settings_page.dart';
import 'timer_edit_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(timerListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('tdance 定时提醒'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: '设置',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
      ),
      body: tasksAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return _EmptyState(onCreate: () => _openEdit(context, ref, null));
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 88),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return TimerCard(
                task: task,
                onTap: () => _openEdit(context, ref, task),
                onEnabledChanged: (value) => ref.read(timerRepositoryProvider).setEnabled(task.id, value),
                onDuplicate: () => _duplicate(ref, task),
                onDelete: () => _confirmDelete(context, ref, task),
              );
            },
          );
        },
        error: (error, stack) => Center(child: Text('加载失败：$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openEdit(context, ref, null),
        icon: const Icon(Icons.add),
        label: const Text('新建'),
      ),
    );
  }

  void _openEdit(BuildContext context, WidgetRef ref, TimerTask? task) {
    final settings = ref.read(appSettingsProvider).value;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => TimerEditPage(existing: task, defaultSettings: settings)),
    );
  }

  Future<void> _duplicate(WidgetRef ref, TimerTask task) async {
    final repo = ref.read(timerRepositoryProvider);
    await repo.create(
      task.copyWith(
        name: '${task.name}（副本）',
        clearNextTriggerAt: true,
        clearLastTriggeredAt: true,
        triggeredCount: 0,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref, TimerTask task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除定时器'),
        content: Text('确定要删除"${task.name}"吗？此操作不可恢复。'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('删除')),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(timerRepositoryProvider).delete(task.id);
    }
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onCreate;

  const _EmptyState({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.alarm_add_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 16),
          const Text('还没有任何定时器'),
          const SizedBox(height: 8),
          FilledButton.icon(onPressed: onCreate, icon: const Icon(Icons.add), label: const Text('新建一个')),
        ],
      ),
    );
  }
}
