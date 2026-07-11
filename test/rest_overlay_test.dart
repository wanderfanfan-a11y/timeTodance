import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdance/domain/models/rest_session.dart';
import 'package:tdance/domain/models/timer_task.dart';
import 'package:tdance/platform/rest/rest_mode_dependencies.dart';
import 'package:tdance/platform/rest/rest_mode_service.dart';
import 'package:tdance/ui/pages/rest_overlay.dart';

class _MemoryStore implements RestSessionStore {
  RestSession? value;

  @override
  Future<RestSession?> load() async => value;

  @override
  Future<void> save(RestSession session) async {
    value = session;
  }

  @override
  Future<void> clear() async {
    value = null;
  }
}

class _FakeWindow implements RestOverlayWindow {
  int exitCount = 0;

  @override
  Future<void> enterRestOverlay() async {}

  @override
  Future<void> exitRestOverlay() async {
    exitCount++;
  }
}

TimerTask _task(DateTime createdAt) {
  return TimerTask(
    id: 'rest-task',
    name: '强制休息',
    message: '起来活动一下',
    type: TimerType.interval,
    intervalSeconds: 3600,
    forceRest: true,
    restDurationMinutes: 5,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

void main() {
  testWidgets('emergency shortcut resets when released before ten seconds', (
    tester,
  ) async {
    final now = DateTime(2026, 1, 1, 9);
    final store = _MemoryStore();
    final window = _FakeWindow();
    final service = RestModeService(
      repository: store,
      windowService: window,
      now: () => now,
    );
    addTearDown(service.dispose);
    await service.start(_task(now));

    await tester.pumpWidget(
      MaterialApp(
        home: RestOverlay(session: service.session.value!, service: service),
      ),
    );

    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.f12);
    await tester.pump(const Duration(seconds: 5));

    expect(service.isActive, isTrue);
    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      closeTo(0.5, 0.02),
    );

    await tester.sendKeyUpEvent(LogicalKeyboardKey.f12);
    await tester.pump();

    expect(
      tester
          .widget<LinearProgressIndicator>(find.byType(LinearProgressIndicator))
          .value,
      0,
    );

    await tester.sendKeyDownEvent(LogicalKeyboardKey.f12);
    await tester.pump(const Duration(seconds: 9));
    expect(service.isActive, isTrue);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(service.isActive, isFalse);
    expect(store.value, isNull);
    expect(window.exitCount, 1);

    await tester.sendKeyUpEvent(LogicalKeyboardKey.f12);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('rest mode ends automatically at its deadline', (tester) async {
    final now = DateTime(2026, 1, 1, 9);
    final store = _MemoryStore();
    final window = _FakeWindow();
    final service = RestModeService(
      repository: store,
      windowService: window,
      now: () => now,
    );
    addTearDown(service.dispose);
    await service.start(_task(now));

    await tester.pumpWidget(
      MaterialApp(
        home: RestOverlay(session: service.session.value!, service: service),
      ),
    );

    await tester.pump(const Duration(minutes: 5));
    await tester.pump();

    expect(service.session.value, isNull);
    expect(store.value, isNull);
    expect(window.exitCount, 1);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
