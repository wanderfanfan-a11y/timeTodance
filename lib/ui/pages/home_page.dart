import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/timer_task.dart';
import '../../state/providers.dart';
import '../widgets/timer_card.dart';
import 'settings_page.dart';
import 'timer_edit_page.dart';

enum _TimerStatusFilter { all, enabled, paused, completed }

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _query = '';
  _TimerStatusFilter _statusFilter = _TimerStatusFilter.all;

  @override
  Widget build(BuildContext context) {
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
          final filteredTasks = tasks.where(_matchesFilters).toList();
          return Column(
            children: [
              _TimerFilters(
                statusFilter: _statusFilter,
                onQueryChanged: (value) => setState(() => _query = value),
                onStatusChanged: (value) => setState(() => _statusFilter = value),
              ),
              Expanded(
                child: filteredTasks.isEmpty
                    ? const _NoMatchesState()
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 2, bottom: 88),
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return TimerCard(
                            task: task,
                            onTap: () => _openEdit(context, ref, task),
                            onEnabledChanged: (value) =>
                                ref.read(timerRepositoryProvider).setEnabled(task.id, value),
                            onDuplicate: () => _duplicate(ref, task),
                            onDelete: () => _confirmDelete(context, ref, task),
                          );
                        },
                      ),
              ),
            ],
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

  bool _matchesFilters(TimerTask task) {
    final query = _query.trim().toLowerCase();
    final matchesQuery =
        query.isEmpty ||
        task.name.toLowerCase().contains(query) ||
        task.message.toLowerCase().contains(query);
    if (!matchesQuery) return false;

    return switch (_statusFilter) {
      _TimerStatusFilter.all => true,
      _TimerStatusFilter.enabled => task.enabled && task.nextTriggerAt != null,
      _TimerStatusFilter.paused => !task.enabled,
      _TimerStatusFilter.completed => task.enabled && task.nextTriggerAt == null,
    };
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

class _TimerFilters extends StatelessWidget {
  final _TimerStatusFilter statusFilter;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<_TimerStatusFilter> onStatusChanged;

  const _TimerFilters({
    required this.statusFilter,
    required this.onQueryChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: '搜索名称或提醒文案',
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
              onChanged: onQueryChanged,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 112,
            child: InputDecorator(
              decoration: const InputDecoration(isDense: true),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<_TimerStatusFilter>(
                  value: statusFilter,
                  isDense: true,
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) onStatusChanged(value);
                  },
                  items: const [
                    DropdownMenuItem(value: _TimerStatusFilter.all, child: Text('全部')),
                    DropdownMenuItem(value: _TimerStatusFilter.enabled, child: Text('启用')),
                    DropdownMenuItem(value: _TimerStatusFilter.paused, child: Text('暂停')),
                    DropdownMenuItem(value: _TimerStatusFilter.completed, child: Text('完成')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoMatchesState extends StatelessWidget {
  const _NoMatchesState();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('没有符合条件的定时器'));
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
