import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdance/data/database/app_database.dart';
import 'package:tdance/data/repositories/rest_session_repository.dart';
import 'package:tdance/data/repositories/timer_repository.dart';
import 'package:tdance/domain/models/rest_session.dart';

void main() {
  test(
    'v1 database migrates forced-rest columns and recovery storage',
    () async {
      final executor = NativeDatabase.memory(
        setup: (database) {
          database.execute('''
          CREATE TABLE timer_tasks_table (
            id TEXT NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            message TEXT NOT NULL DEFAULT '',
            type TEXT NOT NULL,
            enabled INTEGER NOT NULL DEFAULT 1,
            trigger_at INTEGER,
            countdown_seconds INTEGER,
            interval_seconds INTEGER,
            daily_times_json TEXT,
            weekdays_json TEXT,
            active_start_minutes INTEGER,
            active_end_minutes INTEGER,
            end_condition_type TEXT NOT NULL DEFAULT 'never',
            end_date INTEGER,
            end_count INTEGER,
            triggered_count INTEGER NOT NULL DEFAULT 0,
            sound_enabled INTEGER NOT NULL DEFAULT 1,
            sound_id TEXT NOT NULL DEFAULT 'default',
            sound_volume REAL NOT NULL DEFAULT 1.0,
            notify INTEGER NOT NULL DEFAULT 1,
            popup INTEGER NOT NULL DEFAULT 0,
            snooze_minutes INTEGER,
            last_triggered_at INTEGER,
            next_trigger_at INTEGER,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL
          )
        ''');
          database.execute(
            "INSERT INTO timer_tasks_table "
            "(id, name, type, created_at, updated_at) "
            "VALUES ('legacy', '旧定时器', 'once', 0, 0)",
          );
          database.execute('PRAGMA user_version = 1');
        },
      );
      final database = AppDatabase.withExecutor(executor);
      addTearDown(database.close);

      final legacyTask = await TimerRepository(database).findById('legacy');

      expect(legacyTask, isNotNull);
      expect(legacyTask?.name, '旧定时器');
      expect(legacyTask?.forceRest, isFalse);
      expect(legacyTask?.restDurationMinutes, 5);

      final columns = await database
          .customSelect('PRAGMA table_info(timer_tasks_table)')
          .get();
      final columnNames = columns
          .map((row) => row.read<String>('name'))
          .toSet();
      expect(columnNames, containsAll(['force_rest', 'rest_duration_minutes']));

      final repository = RestSessionRepository(database);
      final session = RestSession(
        taskName: '恢复测试',
        message: '继续休息',
        startedAt: DateTime(2026, 1, 1, 9),
        endsAt: DateTime(2026, 1, 1, 9, 5),
      );

      await repository.save(session);
      final restored = await repository.load();

      expect(restored?.taskName, session.taskName);
      expect(restored?.message, session.message);
      expect(restored?.startedAt, session.startedAt);
      expect(restored?.endsAt, session.endsAt);
    },
  );
}
