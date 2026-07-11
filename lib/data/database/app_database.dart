import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'app_database.g.dart';

/// 应用本地数据库（drift + SQLite），完全脱机存储，无网络依赖。
@DriftDatabase(tables: [TimerTasksTable, AppSettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// 供单元测试/集成测试使用，可注入内存数据库等自定义 executor。
  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationSupportDirectory();
      final file = File(p.join(dir.path, 'tdance.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
