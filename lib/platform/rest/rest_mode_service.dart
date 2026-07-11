import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/repositories/rest_session_repository.dart';
import '../../domain/models/rest_session.dart';
import '../../domain/models/timer_task.dart';
import '../window/window_service.dart';

class RestModeService {
  final RestSessionRepository repository;
  final WindowService windowService;

  final ValueNotifier<RestSession?> session = ValueNotifier(null);
  Timer? _endTimer;

  RestModeService({required this.repository, required this.windowService});

  bool get isActive {
    final current = session.value;
    return current != null && current.endsAt.isAfter(DateTime.now());
  }

  Future<void> initialize() async {
    final saved = await repository.load();
    if (saved == null) return;
    if (!saved.endsAt.isAfter(DateTime.now())) {
      await repository.clear();
      return;
    }
    await _activate(saved, persist: false);
  }

  Future<void> start(TimerTask task) async {
    final now = DateTime.now();
    final requestedEnd = now.add(
      Duration(minutes: task.restDurationMinutes.clamp(5, 10)),
    );
    final current = session.value;
    if (current != null && current.endsAt.isAfter(now)) {
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
        startedAt: now,
        endsAt: requestedEnd,
      ),
    );
  }

  Future<void> emergencyExit() => end();

  Future<void> end() async {
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
    _endTimer = Timer(next.endsAt.difference(DateTime.now()), end);
  }

  void dispose() {
    _endTimer?.cancel();
    session.dispose();
  }
}
