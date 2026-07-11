import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdance/domain/models/rest_session.dart';
import 'package:tdance/domain/models/timer_task.dart';
import 'package:tdance/platform/rest/rest_mode_dependencies.dart';
import 'package:tdance/platform/rest/rest_mode_service.dart';

class _MemoryRestSessionStore implements RestSessionStore {
  RestSession? value;
  int saveCount = 0;
  int clearCount = 0;

  @override
  Future<RestSession?> load() async => value;

  @override
  Future<void> save(RestSession session) async {
    value = session;
    saveCount++;
  }

  @override
  Future<void> clear() async {
    value = null;
    clearCount++;
  }
}

class _FakeRestOverlayWindow implements RestOverlayWindow {
  int enterCount = 0;
  int exitCount = 0;
  Completer<void>? exitCompleter;
  Object? exitError;

  @override
  Future<void> enterRestOverlay() async {
    enterCount++;
  }

  @override
  Future<void> exitRestOverlay() {
    exitCount++;
    final error = exitError;
    if (error != null) return Future<void>.error(error);
    return exitCompleter?.future ?? Future<void>.value();
  }
}

TimerTask _restTask({
  String name = '站起来活动',
  String message = '看看远处',
  int durationMinutes = 5,
}) {
  final createdAt = DateTime(2026, 1, 1);
  return TimerTask(
    id: 'rest-task',
    name: name,
    message: message,
    type: TimerType.interval,
    intervalSeconds: 3600,
    forceRest: true,
    restDurationMinutes: durationMinutes,
    createdAt: createdAt,
    updatedAt: createdAt,
  );
}

void main() {
  late DateTime currentTime;
  late _MemoryRestSessionStore store;
  late _FakeRestOverlayWindow window;
  late RestModeService service;

  setUp(() {
    currentTime = DateTime(2026, 1, 1, 9);
    store = _MemoryRestSessionStore();
    window = _FakeRestOverlayWindow();
    service = RestModeService(
      repository: store,
      windowService: window,
      now: () => currentTime,
    );
  });

  tearDown(() {
    service.dispose();
  });

  test('restores an unfinished session and clears it on completion', () async {
    store.value = RestSession(
      taskName: '午间休息',
      message: '离开屏幕',
      startedAt: currentTime.subtract(const Duration(minutes: 1)),
      endsAt: currentTime.add(const Duration(minutes: 4)),
    );

    await service.initialize();

    expect(service.session.value, same(store.value));
    expect(window.enterCount, 1);

    await service.end();

    expect(service.session.value, isNull);
    expect(store.value, isNull);
    expect(store.clearCount, 1);
    expect(window.exitCount, 1);
  });

  test('discards an expired session without entering the overlay', () async {
    store.value = RestSession(
      taskName: '已结束',
      message: '',
      startedAt: currentTime.subtract(const Duration(minutes: 10)),
      endsAt: currentTime.subtract(const Duration(seconds: 1)),
    );

    await service.initialize();

    expect(service.session.value, isNull);
    expect(store.value, isNull);
    expect(store.clearCount, 1);
    expect(window.enterCount, 0);
  });

  test('clamps persisted rest duration to the supported range', () async {
    await service.start(_restTask(durationMinutes: 1));

    expect(service.session.value?.startedAt, currentTime);
    expect(
      service.session.value?.endsAt,
      currentTime.add(const Duration(minutes: 5)),
    );
    expect(store.saveCount, 1);
    expect(window.enterCount, 1);
  });

  test(
    'extends an active rest session when a later deadline is requested',
    () async {
      await service.start(_restTask(durationMinutes: 5));
      currentTime = currentTime.add(const Duration(minutes: 1));

      await service.start(_restTask(durationMinutes: 10));

      expect(
        service.session.value?.endsAt,
        currentTime.add(const Duration(minutes: 10)),
      );
      expect(store.saveCount, 2);
    },
  );

  test('coalesces concurrent attempts to end the session', () async {
    await service.start(_restTask());
    window.exitCompleter = Completer<void>();

    final first = service.end();
    final second = service.end();

    expect(identical(first, second), isTrue);
    expect(window.exitCount, 1);

    window.exitCompleter?.complete();
    await Future.wait([first, second]);

    expect(store.clearCount, 1);
    expect(service.session.value, isNull);
  });

  test('keeps recovery state when the window cannot exit rest mode', () async {
    await service.start(_restTask());
    window.exitError = StateError('window failure');

    await expectLater(service.end(), throwsStateError);

    expect(service.session.value, isNotNull);
    expect(store.value, isNotNull);
    expect(store.clearCount, 0);

    window.exitError = null;
    await service.end();
    expect(service.session.value, isNull);
  });
}
