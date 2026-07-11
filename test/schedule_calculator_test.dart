import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart';
import 'package:tdance/domain/models/timer_task.dart';
import 'package:tdance/domain/schedule/schedule_calculator.dart';

TimerTask _base({
  required TimerType type,
  DateTime? now,
  DateTime? triggerAt,
  int? countdownSeconds,
  int? intervalSeconds,
  List<TimeOfDay> dailyTimes = const [],
  List<int> weekdays = const [],
  TimeOfDay? activeStart,
  TimeOfDay? activeEnd,
  DateTime? lastTriggeredAt,
  DateTime? nextTriggerAt,
  EndCondition endCondition = const EndCondition.never(),
  int triggeredCount = 0,
  DateTime? createdAt,
}) {
  final created = createdAt ?? now ?? DateTime(2026, 1, 1, 0, 0, 0);
  return TimerTask(
    id: 'test-id',
    name: 'test',
    type: type,
    triggerAt: triggerAt,
    countdownSeconds: countdownSeconds,
    intervalSeconds: intervalSeconds,
    dailyTimes: dailyTimes,
    weekdays: weekdays,
    activeStart: activeStart,
    activeEnd: activeEnd,
    lastTriggeredAt: lastTriggeredAt,
    nextTriggerAt: nextTriggerAt,
    endCondition: endCondition,
    triggeredCount: triggeredCount,
    createdAt: created,
    updatedAt: created,
  );
}

void main() {
  final calculator = const ScheduleCalculator();

  group('once', () {
    test('future triggerAt is kept', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final triggerAt = DateTime(2026, 1, 1, 12, 0, 0);
      final task = _base(type: TimerType.once, now: now, triggerAt: triggerAt);
      expect(calculator.computeNextTrigger(task, now), triggerAt);
    });

    test('missed triggerAt does not fire (no backfill)', () {
      final now = DateTime(2026, 1, 1, 13, 0, 0);
      final triggerAt = DateTime(2026, 1, 1, 12, 0, 0);
      final task = _base(type: TimerType.once, now: now, triggerAt: triggerAt);
      expect(calculator.computeNextTrigger(task, now), isNull);
    });
  });

  group('countdown', () {
    test('first computation adds countdownSeconds to now', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final task = _base(type: TimerType.countdown, now: now, countdownSeconds: 1500);
      expect(calculator.computeNextTrigger(task, now), now.add(const Duration(seconds: 1500)));
    });

    test('subsequent recompute keeps stored nextTriggerAt if still future', () {
      final now = DateTime(2026, 1, 1, 10, 0, 0);
      final stored = DateTime(2026, 1, 1, 10, 25, 0);
      final task = _base(
        type: TimerType.countdown,
        now: now,
        countdownSeconds: 1500,
        nextTriggerAt: stored,
      );
      expect(calculator.computeNextTrigger(task, now), stored);
    });

    test('expired countdown after restart does not refire', () {
      final stored = DateTime(2026, 1, 1, 10, 25, 0);
      final now = DateTime(2026, 1, 1, 11, 0, 0); // app was closed past the target
      final task = _base(
        type: TimerType.countdown,
        countdownSeconds: 1500,
        nextTriggerAt: stored,
        createdAt: DateTime(2026, 1, 1, 10, 0, 0),
      );
      expect(calculator.computeNextTrigger(task, now), isNull);
    });
  });

  group('interval', () {
    test('anchors on createdAt when never triggered', () {
      final created = DateTime(2026, 1, 1, 9, 0, 0);
      final now = DateTime(2026, 1, 1, 9, 10, 0);
      final task = _base(type: TimerType.interval, intervalSeconds: 45 * 60, createdAt: created);
      expect(calculator.computeNextTrigger(task, now), created.add(const Duration(minutes: 45)));
    });

    test('skips missed occurrences after long sleep without drifting phase', () {
      final created = DateTime(2026, 1, 1, 9, 0, 0);
      final now = DateTime(2026, 1, 2, 10, 3, 0); // long time later
      final task = _base(type: TimerType.interval, intervalSeconds: 45 * 60, createdAt: created);
      final next = calculator.computeNextTrigger(task, now)!;
      expect(next.isAfter(now), isTrue);
      // 保持与 anchor 的相位一致：分钟数应仍然落在 0/45 分钟网格上。
      expect(next.difference(created).inMinutes % 45, 0);
    });

    test('respects active window, rolling forward to next window start', () {
      final created = DateTime(2026, 1, 1, 17, 50, 0);
      final now = DateTime(2026, 1, 1, 17, 55, 0);
      final task = _base(
        type: TimerType.interval,
        intervalSeconds: 20 * 60,
        createdAt: created,
        activeStart: const TimeOfDay(hour: 9, minute: 0),
        activeEnd: const TimeOfDay(hour: 18, minute: 0),
      );
      // 原始候选 18:10 落在窗口外，应被顺延到次日 09:00。
      final next = calculator.computeNextTrigger(task, now)!;
      expect(next, DateTime(2026, 1, 2, 9, 0, 0));
    });

    test('respects weekday filter for workday-only reminders', () {
      // 2026-01-03 是周六。
      final created = DateTime(2026, 1, 3, 9, 0, 0);
      final now = DateTime(2026, 1, 3, 9, 30, 0);
      final task = _base(
        type: TimerType.interval,
        intervalSeconds: 60 * 60,
        createdAt: created,
        weekdays: const [1, 2, 3, 4, 5],
      );
      final next = calculator.computeNextTrigger(task, now)!;
      expect(next.weekday, lessThanOrEqualTo(5));
    });
  });

  group('daily', () {
    test('finds earliest remaining time today', () {
      final now = DateTime(2026, 1, 1, 9, 0, 0);
      final task = _base(
        type: TimerType.daily,
        dailyTimes: const [TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 20, minute: 0)],
        createdAt: DateTime(2026, 1, 1),
      );
      expect(calculator.computeNextTrigger(task, now), DateTime(2026, 1, 1, 20, 0, 0));
    });

    test('rolls to tomorrow when all times today have passed', () {
      final now = DateTime(2026, 1, 1, 21, 0, 0);
      final task = _base(
        type: TimerType.daily,
        dailyTimes: const [TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 20, minute: 0)],
        createdAt: DateTime(2026, 1, 1),
      );
      expect(calculator.computeNextTrigger(task, now), DateTime(2026, 1, 2, 8, 0, 0));
    });
  });

  group('weekly', () {
    test('finds next matching weekday', () {
      // 2026-01-01 是周四。选择周一/周三/周五 10:00。
      final now = DateTime(2026, 1, 1, 9, 0, 0);
      final task = _base(
        type: TimerType.weekly,
        dailyTimes: const [TimeOfDay(hour: 10, minute: 0)],
        weekdays: const [1, 3, 5],
        createdAt: DateTime(2026, 1, 1),
      );
      expect(calculator.computeNextTrigger(task, now), DateTime(2026, 1, 2, 10, 0, 0)); // 周五
    });
  });

  group('end condition', () {
    test('byCount stops future triggers once reached', () {
      final now = DateTime(2026, 1, 1, 9, 0, 0);
      final task = _base(
        type: TimerType.interval,
        intervalSeconds: 60,
        createdAt: now,
        endCondition: const EndCondition.byCount(3),
        triggeredCount: 3,
      );
      expect(calculator.computeNextTrigger(task, now), isNull);
    });

    test('byDate stops triggers after the end date', () {
      final created = DateTime(2026, 1, 1, 9, 0, 0);
      final now = DateTime(2026, 1, 1, 9, 0, 30);
      final task = _base(
        type: TimerType.interval,
        intervalSeconds: 60,
        createdAt: created,
        endCondition: EndCondition.byDate(DateTime(2026, 1, 1, 9, 0, 45)),
      );
      expect(calculator.computeNextTrigger(task, now), isNull);
    });
  });
}
