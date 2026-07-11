import 'package:drift/drift.dart';

import '../../domain/models/rest_session.dart';
import '../database/app_database.dart';

class RestSessionRepository {
  final AppDatabase _db;

  const RestSessionRepository(this._db);

  Future<RestSession?> load() async {
    final row = await (_db.select(
      _db.restSessionsTable,
    )..where((t) => t.id.equals(0))).getSingleOrNull();
    if (row == null) return null;
    return RestSession(
      taskName: row.taskName,
      message: row.message,
      startedAt: row.startedAt,
      endsAt: row.endsAt,
    );
  }

  Future<void> save(RestSession session) async {
    await _db
        .into(_db.restSessionsTable)
        .insertOnConflictUpdate(
          RestSessionsTableCompanion(
            id: const Value(0),
            taskName: Value(session.taskName),
            message: Value(session.message),
            startedAt: Value(session.startedAt),
            endsAt: Value(session.endsAt),
          ),
        );
  }

  Future<void> clear() async {
    await (_db.delete(
      _db.restSessionsTable,
    )..where((t) => t.id.equals(0))).go();
  }
}
