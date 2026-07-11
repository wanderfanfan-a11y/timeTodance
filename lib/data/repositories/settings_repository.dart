import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

import '../../domain/models/app_settings.dart';
import '../../domain/schedule/schedule_calculator.dart';
import '../database/app_database.dart';

/// 应用设置数据仓库：单行记录，id 固定为 0，首次访问时自动创建默认设置。
class SettingsRepository {
  static const int _rowId = 0;

  final AppDatabase _db;

  SettingsRepository(this._db);

  Stream<AppSettings> watch() {
    final query = _db.select(_db.appSettingsTable)..where((t) => t.id.equals(_rowId));
    return query.watchSingleOrNull().asyncMap((row) async {
      if (row == null) {
        await _ensureDefaultRow();
        return const AppSettings();
      }
      return _toDomain(row);
    });
  }

  Future<AppSettings> load() async {
    final row = await (_db.select(_db.appSettingsTable)..where((t) => t.id.equals(_rowId))).getSingleOrNull();
    if (row == null) {
      await _ensureDefaultRow();
      return const AppSettings();
    }
    return _toDomain(row);
  }

  Future<void> save(AppSettings settings) async {
    await _db.into(_db.appSettingsTable).insertOnConflictUpdate(_toCompanion(settings));
  }

  Future<void> _ensureDefaultRow() async {
    await _db.into(_db.appSettingsTable).insertOnConflictUpdate(_toCompanion(const AppSettings()));
  }

  AppSettings _toDomain(AppSettingsEntity row) {
    return AppSettings(
      startOnLogin: row.startOnLogin,
      minimizeToTrayOnClose: row.minimizeToTrayOnClose,
      defaultNotify: row.defaultNotify,
      defaultSound: row.defaultSound,
      defaultVolume: row.defaultVolume,
      defaultSoundId: row.defaultSoundId,
      dndEnabled: row.dndEnabled,
      dndStart: row.dndStartMinutes == null ? null : minutesToTimeOfDay(row.dndStartMinutes!),
      dndEnd: row.dndEndMinutes == null ? null : minutesToTimeOfDay(row.dndEndMinutes!),
      themeMode: ThemeMode.values.byName(row.themeMode),
    );
  }

  AppSettingsTableCompanion _toCompanion(AppSettings settings) {
    return AppSettingsTableCompanion(
      id: const Value(_rowId),
      startOnLogin: Value(settings.startOnLogin),
      minimizeToTrayOnClose: Value(settings.minimizeToTrayOnClose),
      defaultNotify: Value(settings.defaultNotify),
      defaultSound: Value(settings.defaultSound),
      defaultVolume: Value(settings.defaultVolume),
      defaultSoundId: Value(settings.defaultSoundId),
      dndEnabled: Value(settings.dndEnabled),
      dndStartMinutes: Value(settings.dndStart == null ? null : timeOfDayToMinutes(settings.dndStart!)),
      dndEndMinutes: Value(settings.dndEnd == null ? null : timeOfDayToMinutes(settings.dndEnd!)),
      themeMode: Value(settings.themeMode.name),
    );
  }
}
