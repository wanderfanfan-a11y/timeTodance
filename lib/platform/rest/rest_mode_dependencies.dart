import '../../domain/models/rest_session.dart';

abstract interface class RestSessionStore {
  Future<RestSession?> load();

  Future<void> save(RestSession session);

  Future<void> clear();
}

abstract interface class RestOverlayWindow {
  Future<void> enterRestOverlay();

  Future<void> exitRestOverlay();
}
