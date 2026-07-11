import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/models/rest_session.dart';
import '../../domain/models/timer_task.dart';
import 'rest_mode_dependencies.dart';

class RestModeService {
  final RestSessionStore repository;
  final RestOverlayWindow windowService;
  final DateTime Function() now;

  final ValueNotifier<RestSession?> session = ValueNotifier(null);
  Timer? _endTimer;
  Future<void>? _endOperation;

  RestModeService({
    required this.repository,
    required this.windowService,
    DateTime Function()? now,
  }) : now = now ?? DateTime.now;

  bool get isActive {
    final current = session.value;
    return current != null && current.endsAt.isAfter(now());
  }

  Future<void> initialize() async {
    final saved = await repository.load();
    if (saved == null) return;
    if (!saved.endsAt.isAfter(now())) {
      await repository.clear();
      return;
    }
    await _activate(saved, persist: false);
  }

  Future<void> start(TimerTask task) async {
    final startedAt = now();
    final requestedEnd = startedAt.add(
      Duration(minutes: task.restDurationMinutes.clamp(5, 10)),
    );
    final current = session.value;
    if (current != null && current.endsAt.isAfter(startedAt)) {
      if (!requestedEnd.isAfter(current.endsAt)) return;
      await _activate(
        RestSession(
          taskName: current.taskName,
          message: current.message,
          startedAt: current.startedAt,
          endsAt: requestedEnd,
        ),
      );
      return;
    }

    await _activate(
      RestSession(
        taskName: task.name,
        message: task.message,
        startedAt: startedAt,
        endsAt: requestedEnd,
      ),
    );
  }

  Future<void> emergencyExit() => end();

  Future<void> end() {
    final pending = _endOperation;
    if (pending != null) return pending;
    late final Future<void> operation;
    operation = _finishEnd().whenComplete(() {
      if (identical(_endOperation, operation)) {
        _endOperation = null;
      }
    });
    _endOperation = operation;
    return operation;
  }

  Future<void> _finishEnd() async {
    _endTimer?.cancel();
    _endTimer = null;
    await windowService.exitRestOverlay();
    session.value = null;
    await repository.clear();
  }

  Future<void> _activate(RestSession next, {bool persist = true}) async {
    _endTimer?.cancel();
    if (persist) {
      await repository.save(next);
    }
    session.value = next;
    await windowService.enterRestOverlay();
    _endTimer = Timer(next.endsAt.difference(now()), () {
      unawaited(end());
    });
  }

  void dispose() {
    _endTimer?.cancel();
    session.dispose();
  }
}
