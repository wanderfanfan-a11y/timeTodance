import 'package:drift/drift.dart';

/// 定时器任务表。
///
/// 复杂结构（每日多时刻、生效星期）以 JSON 字符串存储；时间点统一以
/// "一天中的第几分钟"（0-1439）存储，避免为 TimeOfDay 编写额外的 TypeConverter，
/// 让数据层保持简单、类型安全。领域模型 <-> 表行 的换算在 Repository 中完成。
@DataClassName('TimerTaskEntity')
class TimerTasksTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get message => text().withDefault(const Constant(''))();

  /// TimerType 的枚举名（once/countdown/interval/daily/weekly）。
  TextColumn get type => text()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();

  /// 一次性·指定时刻
  DateTimeColumn get triggerAt => dateTime().nullable()();

  /// 一次性·倒计时（秒）
  IntColumn get countdownSeconds => integer().nullable()();

  /// 周期性·固定间隔（秒）
  IntColumn get intervalSeconds => integer().nullable()();

  /// JSON 数组，每日固定时刻（分钟数），如 [480, 1200]。
  TextColumn get dailyTimesJson => text().nullable()();

  /// JSON 数组，生效星期（1=周一..7=周日）。
  TextColumn get weekdaysJson => text().nullable()();

  /// 生效时段限制（分钟数），仅 interval 类型使用。
  IntColumn get activeStartMinutes => integer().nullable()();
  IntColumn get activeEndMinutes => integer().nullable()();

  /// EndConditionType 的枚举名（never/byDate/byCount）。
  TextColumn get endConditionType => text().withDefault(const Constant('never'))();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get endCount => integer().nullable()();
  IntColumn get triggeredCount => integer().withDefault(const Constant(0))();

  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  TextColumn get soundId => text().withDefault(const Constant('default'))();
  RealColumn get soundVolume => real().withDefault(const Constant(1.0))();

  BoolColumn get notify => boolean().withDefault(const Constant(true))();
  BoolColumn get popup => boolean().withDefault(const Constant(false))();
  IntColumn get snoozeMinutes => integer().nullable()();

  DateTimeColumn get lastTriggeredAt => dateTime().nullable()();
  DateTimeColumn get nextTriggerAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 应用设置表：单行记录（id 固定为 0）。
@DataClassName('AppSettingsEntity')
class AppSettingsTable extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();

  BoolColumn get startOnLogin => boolean().withDefault(const Constant(false))();
  BoolColumn get minimizeToTrayOnClose => boolean().withDefault(const Constant(true))();
  BoolColumn get defaultNotify => boolean().withDefault(const Constant(true))();
  BoolColumn get defaultSound => boolean().withDefault(const Constant(true))();
  RealColumn get defaultVolume => real().withDefault(const Constant(1.0))();
  TextColumn get defaultSoundId => text().withDefault(const Constant('default'))();

  BoolColumn get dndEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get dndStartMinutes => integer().nullable()();
  IntColumn get dndEndMinutes => integer().nullable()();

  /// ThemeMode 的枚举名（system/light/dark）。
  TextColumn get themeMode => text().withDefault(const Constant('system'))();

  @override
  Set<Column> get primaryKey => {id};
}
