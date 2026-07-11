// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TimerTasksTableTable extends TimerTasksTable
    with TableInfo<$TimerTasksTableTable, TimerTaskEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimerTasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _triggerAtMeta = const VerificationMeta(
    'triggerAt',
  );
  @override
  late final GeneratedColumn<DateTime> triggerAt = GeneratedColumn<DateTime>(
    'trigger_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countdownSecondsMeta = const VerificationMeta(
    'countdownSeconds',
  );
  @override
  late final GeneratedColumn<int> countdownSeconds = GeneratedColumn<int>(
    'countdown_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intervalSecondsMeta = const VerificationMeta(
    'intervalSeconds',
  );
  @override
  late final GeneratedColumn<int> intervalSeconds = GeneratedColumn<int>(
    'interval_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyTimesJsonMeta = const VerificationMeta(
    'dailyTimesJson',
  );
  @override
  late final GeneratedColumn<String> dailyTimesJson = GeneratedColumn<String>(
    'daily_times_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekdaysJsonMeta = const VerificationMeta(
    'weekdaysJson',
  );
  @override
  late final GeneratedColumn<String> weekdaysJson = GeneratedColumn<String>(
    'weekdays_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeStartMinutesMeta =
      const VerificationMeta('activeStartMinutes');
  @override
  late final GeneratedColumn<int> activeStartMinutes = GeneratedColumn<int>(
    'active_start_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeEndMinutesMeta = const VerificationMeta(
    'activeEndMinutes',
  );
  @override
  late final GeneratedColumn<int> activeEndMinutes = GeneratedColumn<int>(
    'active_end_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endConditionTypeMeta = const VerificationMeta(
    'endConditionType',
  );
  @override
  late final GeneratedColumn<String> endConditionType = GeneratedColumn<String>(
    'end_condition_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('never'),
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endCountMeta = const VerificationMeta(
    'endCount',
  );
  @override
  late final GeneratedColumn<int> endCount = GeneratedColumn<int>(
    'end_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _triggeredCountMeta = const VerificationMeta(
    'triggeredCount',
  );
  @override
  late final GeneratedColumn<int> triggeredCount = GeneratedColumn<int>(
    'triggered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _soundIdMeta = const VerificationMeta(
    'soundId',
  );
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
    'sound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _soundVolumeMeta = const VerificationMeta(
    'soundVolume',
  );
  @override
  late final GeneratedColumn<double> soundVolume = GeneratedColumn<double>(
    'sound_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _notifyMeta = const VerificationMeta('notify');
  @override
  late final GeneratedColumn<bool> notify = GeneratedColumn<bool>(
    'notify',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _popupMeta = const VerificationMeta('popup');
  @override
  late final GeneratedColumn<bool> popup = GeneratedColumn<bool>(
    'popup',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("popup" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _snoozeMinutesMeta = const VerificationMeta(
    'snoozeMinutes',
  );
  @override
  late final GeneratedColumn<int> snoozeMinutes = GeneratedColumn<int>(
    'snooze_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastTriggeredAtMeta = const VerificationMeta(
    'lastTriggeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastTriggeredAt =
      GeneratedColumn<DateTime>(
        'last_triggered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextTriggerAtMeta = const VerificationMeta(
    'nextTriggerAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextTriggerAt =
      GeneratedColumn<DateTime>(
        'next_trigger_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    message,
    type,
    enabled,
    triggerAt,
    countdownSeconds,
    intervalSeconds,
    dailyTimesJson,
    weekdaysJson,
    activeStartMinutes,
    activeEndMinutes,
    endConditionType,
    endDate,
    endCount,
    triggeredCount,
    soundEnabled,
    soundId,
    soundVolume,
    notify,
    popup,
    snoozeMinutes,
    lastTriggeredAt,
    nextTriggerAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timer_tasks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimerTaskEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('trigger_at')) {
      context.handle(
        _triggerAtMeta,
        triggerAt.isAcceptableOrUnknown(data['trigger_at']!, _triggerAtMeta),
      );
    }
    if (data.containsKey('countdown_seconds')) {
      context.handle(
        _countdownSecondsMeta,
        countdownSeconds.isAcceptableOrUnknown(
          data['countdown_seconds']!,
          _countdownSecondsMeta,
        ),
      );
    }
    if (data.containsKey('interval_seconds')) {
      context.handle(
        _intervalSecondsMeta,
        intervalSeconds.isAcceptableOrUnknown(
          data['interval_seconds']!,
          _intervalSecondsMeta,
        ),
      );
    }
    if (data.containsKey('daily_times_json')) {
      context.handle(
        _dailyTimesJsonMeta,
        dailyTimesJson.isAcceptableOrUnknown(
          data['daily_times_json']!,
          _dailyTimesJsonMeta,
        ),
      );
    }
    if (data.containsKey('weekdays_json')) {
      context.handle(
        _weekdaysJsonMeta,
        weekdaysJson.isAcceptableOrUnknown(
          data['weekdays_json']!,
          _weekdaysJsonMeta,
        ),
      );
    }
    if (data.containsKey('active_start_minutes')) {
      context.handle(
        _activeStartMinutesMeta,
        activeStartMinutes.isAcceptableOrUnknown(
          data['active_start_minutes']!,
          _activeStartMinutesMeta,
        ),
      );
    }
    if (data.containsKey('active_end_minutes')) {
      context.handle(
        _activeEndMinutesMeta,
        activeEndMinutes.isAcceptableOrUnknown(
          data['active_end_minutes']!,
          _activeEndMinutesMeta,
        ),
      );
    }
    if (data.containsKey('end_condition_type')) {
      context.handle(
        _endConditionTypeMeta,
        endConditionType.isAcceptableOrUnknown(
          data['end_condition_type']!,
          _endConditionTypeMeta,
        ),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('end_count')) {
      context.handle(
        _endCountMeta,
        endCount.isAcceptableOrUnknown(data['end_count']!, _endCountMeta),
      );
    }
    if (data.containsKey('triggered_count')) {
      context.handle(
        _triggeredCountMeta,
        triggeredCount.isAcceptableOrUnknown(
          data['triggered_count']!,
          _triggeredCountMeta,
        ),
      );
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sound_id')) {
      context.handle(
        _soundIdMeta,
        soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta),
      );
    }
    if (data.containsKey('sound_volume')) {
      context.handle(
        _soundVolumeMeta,
        soundVolume.isAcceptableOrUnknown(
          data['sound_volume']!,
          _soundVolumeMeta,
        ),
      );
    }
    if (data.containsKey('notify')) {
      context.handle(
        _notifyMeta,
        notify.isAcceptableOrUnknown(data['notify']!, _notifyMeta),
      );
    }
    if (data.containsKey('popup')) {
      context.handle(
        _popupMeta,
        popup.isAcceptableOrUnknown(data['popup']!, _popupMeta),
      );
    }
    if (data.containsKey('snooze_minutes')) {
      context.handle(
        _snoozeMinutesMeta,
        snoozeMinutes.isAcceptableOrUnknown(
          data['snooze_minutes']!,
          _snoozeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('last_triggered_at')) {
      context.handle(
        _lastTriggeredAtMeta,
        lastTriggeredAt.isAcceptableOrUnknown(
          data['last_triggered_at']!,
          _lastTriggeredAtMeta,
        ),
      );
    }
    if (data.containsKey('next_trigger_at')) {
      context.handle(
        _nextTriggerAtMeta,
        nextTriggerAt.isAcceptableOrUnknown(
          data['next_trigger_at']!,
          _nextTriggerAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimerTaskEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerTaskEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      triggerAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}trigger_at'],
      ),
      countdownSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}countdown_seconds'],
      ),
      intervalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_seconds'],
      ),
      dailyTimesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}daily_times_json'],
      ),
      weekdaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekdays_json'],
      ),
      activeStartMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_start_minutes'],
      ),
      activeEndMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_end_minutes'],
      ),
      endConditionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_condition_type'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      endCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_count'],
      ),
      triggeredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}triggered_count'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      soundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sound_id'],
      )!,
      soundVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sound_volume'],
      )!,
      notify: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify'],
      )!,
      popup: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}popup'],
      )!,
      snoozeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}snooze_minutes'],
      ),
      lastTriggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_triggered_at'],
      ),
      nextTriggerAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_trigger_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TimerTasksTableTable createAlias(String alias) {
    return $TimerTasksTableTable(attachedDatabase, alias);
  }
}

class TimerTaskEntity extends DataClass implements Insertable<TimerTaskEntity> {
  final String id;
  final String name;
  final String message;

  /// TimerType 的枚举名（once/countdown/interval/daily/weekly）。
  final String type;
  final bool enabled;

  /// 一次性·指定时刻
  final DateTime? triggerAt;

  /// 一次性·倒计时（秒）
  final int? countdownSeconds;

  /// 周期性·固定间隔（秒）
  final int? intervalSeconds;

  /// JSON 数组，每日固定时刻（分钟数），如 [480, 1200]。
  final String? dailyTimesJson;

  /// JSON 数组，生效星期（1=周一..7=周日）。
  final String? weekdaysJson;

  /// 生效时段限制（分钟数），仅 interval 类型使用。
  final int? activeStartMinutes;
  final int? activeEndMinutes;

  /// EndConditionType 的枚举名（never/byDate/byCount）。
  final String endConditionType;
  final DateTime? endDate;
  final int? endCount;
  final int triggeredCount;
  final bool soundEnabled;
  final String soundId;
  final double soundVolume;
  final bool notify;
  final bool popup;
  final int? snoozeMinutes;
  final DateTime? lastTriggeredAt;
  final DateTime? nextTriggerAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TimerTaskEntity({
    required this.id,
    required this.name,
    required this.message,
    required this.type,
    required this.enabled,
    this.triggerAt,
    this.countdownSeconds,
    this.intervalSeconds,
    this.dailyTimesJson,
    this.weekdaysJson,
    this.activeStartMinutes,
    this.activeEndMinutes,
    required this.endConditionType,
    this.endDate,
    this.endCount,
    required this.triggeredCount,
    required this.soundEnabled,
    required this.soundId,
    required this.soundVolume,
    required this.notify,
    required this.popup,
    this.snoozeMinutes,
    this.lastTriggeredAt,
    this.nextTriggerAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['message'] = Variable<String>(message);
    map['type'] = Variable<String>(type);
    map['enabled'] = Variable<bool>(enabled);
    if (!nullToAbsent || triggerAt != null) {
      map['trigger_at'] = Variable<DateTime>(triggerAt);
    }
    if (!nullToAbsent || countdownSeconds != null) {
      map['countdown_seconds'] = Variable<int>(countdownSeconds);
    }
    if (!nullToAbsent || intervalSeconds != null) {
      map['interval_seconds'] = Variable<int>(intervalSeconds);
    }
    if (!nullToAbsent || dailyTimesJson != null) {
      map['daily_times_json'] = Variable<String>(dailyTimesJson);
    }
    if (!nullToAbsent || weekdaysJson != null) {
      map['weekdays_json'] = Variable<String>(weekdaysJson);
    }
    if (!nullToAbsent || activeStartMinutes != null) {
      map['active_start_minutes'] = Variable<int>(activeStartMinutes);
    }
    if (!nullToAbsent || activeEndMinutes != null) {
      map['active_end_minutes'] = Variable<int>(activeEndMinutes);
    }
    map['end_condition_type'] = Variable<String>(endConditionType);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || endCount != null) {
      map['end_count'] = Variable<int>(endCount);
    }
    map['triggered_count'] = Variable<int>(triggeredCount);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['sound_id'] = Variable<String>(soundId);
    map['sound_volume'] = Variable<double>(soundVolume);
    map['notify'] = Variable<bool>(notify);
    map['popup'] = Variable<bool>(popup);
    if (!nullToAbsent || snoozeMinutes != null) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes);
    }
    if (!nullToAbsent || lastTriggeredAt != null) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt);
    }
    if (!nullToAbsent || nextTriggerAt != null) {
      map['next_trigger_at'] = Variable<DateTime>(nextTriggerAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TimerTasksTableCompanion toCompanion(bool nullToAbsent) {
    return TimerTasksTableCompanion(
      id: Value(id),
      name: Value(name),
      message: Value(message),
      type: Value(type),
      enabled: Value(enabled),
      triggerAt: triggerAt == null && nullToAbsent
          ? const Value.absent()
          : Value(triggerAt),
      countdownSeconds: countdownSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(countdownSeconds),
      intervalSeconds: intervalSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(intervalSeconds),
      dailyTimesJson: dailyTimesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyTimesJson),
      weekdaysJson: weekdaysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(weekdaysJson),
      activeStartMinutes: activeStartMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(activeStartMinutes),
      activeEndMinutes: activeEndMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(activeEndMinutes),
      endConditionType: Value(endConditionType),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      endCount: endCount == null && nullToAbsent
          ? const Value.absent()
          : Value(endCount),
      triggeredCount: Value(triggeredCount),
      soundEnabled: Value(soundEnabled),
      soundId: Value(soundId),
      soundVolume: Value(soundVolume),
      notify: Value(notify),
      popup: Value(popup),
      snoozeMinutes: snoozeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozeMinutes),
      lastTriggeredAt: lastTriggeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriggeredAt),
      nextTriggerAt: nextTriggerAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextTriggerAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TimerTaskEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerTaskEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      message: serializer.fromJson<String>(json['message']),
      type: serializer.fromJson<String>(json['type']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      triggerAt: serializer.fromJson<DateTime?>(json['triggerAt']),
      countdownSeconds: serializer.fromJson<int?>(json['countdownSeconds']),
      intervalSeconds: serializer.fromJson<int?>(json['intervalSeconds']),
      dailyTimesJson: serializer.fromJson<String?>(json['dailyTimesJson']),
      weekdaysJson: serializer.fromJson<String?>(json['weekdaysJson']),
      activeStartMinutes: serializer.fromJson<int?>(json['activeStartMinutes']),
      activeEndMinutes: serializer.fromJson<int?>(json['activeEndMinutes']),
      endConditionType: serializer.fromJson<String>(json['endConditionType']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      endCount: serializer.fromJson<int?>(json['endCount']),
      triggeredCount: serializer.fromJson<int>(json['triggeredCount']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      soundId: serializer.fromJson<String>(json['soundId']),
      soundVolume: serializer.fromJson<double>(json['soundVolume']),
      notify: serializer.fromJson<bool>(json['notify']),
      popup: serializer.fromJson<bool>(json['popup']),
      snoozeMinutes: serializer.fromJson<int?>(json['snoozeMinutes']),
      lastTriggeredAt: serializer.fromJson<DateTime?>(json['lastTriggeredAt']),
      nextTriggerAt: serializer.fromJson<DateTime?>(json['nextTriggerAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'message': serializer.toJson<String>(message),
      'type': serializer.toJson<String>(type),
      'enabled': serializer.toJson<bool>(enabled),
      'triggerAt': serializer.toJson<DateTime?>(triggerAt),
      'countdownSeconds': serializer.toJson<int?>(countdownSeconds),
      'intervalSeconds': serializer.toJson<int?>(intervalSeconds),
      'dailyTimesJson': serializer.toJson<String?>(dailyTimesJson),
      'weekdaysJson': serializer.toJson<String?>(weekdaysJson),
      'activeStartMinutes': serializer.toJson<int?>(activeStartMinutes),
      'activeEndMinutes': serializer.toJson<int?>(activeEndMinutes),
      'endConditionType': serializer.toJson<String>(endConditionType),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'endCount': serializer.toJson<int?>(endCount),
      'triggeredCount': serializer.toJson<int>(triggeredCount),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'soundId': serializer.toJson<String>(soundId),
      'soundVolume': serializer.toJson<double>(soundVolume),
      'notify': serializer.toJson<bool>(notify),
      'popup': serializer.toJson<bool>(popup),
      'snoozeMinutes': serializer.toJson<int?>(snoozeMinutes),
      'lastTriggeredAt': serializer.toJson<DateTime?>(lastTriggeredAt),
      'nextTriggerAt': serializer.toJson<DateTime?>(nextTriggerAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TimerTaskEntity copyWith({
    String? id,
    String? name,
    String? message,
    String? type,
    bool? enabled,
    Value<DateTime?> triggerAt = const Value.absent(),
    Value<int?> countdownSeconds = const Value.absent(),
    Value<int?> intervalSeconds = const Value.absent(),
    Value<String?> dailyTimesJson = const Value.absent(),
    Value<String?> weekdaysJson = const Value.absent(),
    Value<int?> activeStartMinutes = const Value.absent(),
    Value<int?> activeEndMinutes = const Value.absent(),
    String? endConditionType,
    Value<DateTime?> endDate = const Value.absent(),
    Value<int?> endCount = const Value.absent(),
    int? triggeredCount,
    bool? soundEnabled,
    String? soundId,
    double? soundVolume,
    bool? notify,
    bool? popup,
    Value<int?> snoozeMinutes = const Value.absent(),
    Value<DateTime?> lastTriggeredAt = const Value.absent(),
    Value<DateTime?> nextTriggerAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TimerTaskEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    message: message ?? this.message,
    type: type ?? this.type,
    enabled: enabled ?? this.enabled,
    triggerAt: triggerAt.present ? triggerAt.value : this.triggerAt,
    countdownSeconds: countdownSeconds.present
        ? countdownSeconds.value
        : this.countdownSeconds,
    intervalSeconds: intervalSeconds.present
        ? intervalSeconds.value
        : this.intervalSeconds,
    dailyTimesJson: dailyTimesJson.present
        ? dailyTimesJson.value
        : this.dailyTimesJson,
    weekdaysJson: weekdaysJson.present ? weekdaysJson.value : this.weekdaysJson,
    activeStartMinutes: activeStartMinutes.present
        ? activeStartMinutes.value
        : this.activeStartMinutes,
    activeEndMinutes: activeEndMinutes.present
        ? activeEndMinutes.value
        : this.activeEndMinutes,
    endConditionType: endConditionType ?? this.endConditionType,
    endDate: endDate.present ? endDate.value : this.endDate,
    endCount: endCount.present ? endCount.value : this.endCount,
    triggeredCount: triggeredCount ?? this.triggeredCount,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    soundId: soundId ?? this.soundId,
    soundVolume: soundVolume ?? this.soundVolume,
    notify: notify ?? this.notify,
    popup: popup ?? this.popup,
    snoozeMinutes: snoozeMinutes.present
        ? snoozeMinutes.value
        : this.snoozeMinutes,
    lastTriggeredAt: lastTriggeredAt.present
        ? lastTriggeredAt.value
        : this.lastTriggeredAt,
    nextTriggerAt: nextTriggerAt.present
        ? nextTriggerAt.value
        : this.nextTriggerAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TimerTaskEntity copyWithCompanion(TimerTasksTableCompanion data) {
    return TimerTaskEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      message: data.message.present ? data.message.value : this.message,
      type: data.type.present ? data.type.value : this.type,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      triggerAt: data.triggerAt.present ? data.triggerAt.value : this.triggerAt,
      countdownSeconds: data.countdownSeconds.present
          ? data.countdownSeconds.value
          : this.countdownSeconds,
      intervalSeconds: data.intervalSeconds.present
          ? data.intervalSeconds.value
          : this.intervalSeconds,
      dailyTimesJson: data.dailyTimesJson.present
          ? data.dailyTimesJson.value
          : this.dailyTimesJson,
      weekdaysJson: data.weekdaysJson.present
          ? data.weekdaysJson.value
          : this.weekdaysJson,
      activeStartMinutes: data.activeStartMinutes.present
          ? data.activeStartMinutes.value
          : this.activeStartMinutes,
      activeEndMinutes: data.activeEndMinutes.present
          ? data.activeEndMinutes.value
          : this.activeEndMinutes,
      endConditionType: data.endConditionType.present
          ? data.endConditionType.value
          : this.endConditionType,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      endCount: data.endCount.present ? data.endCount.value : this.endCount,
      triggeredCount: data.triggeredCount.present
          ? data.triggeredCount.value
          : this.triggeredCount,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      soundVolume: data.soundVolume.present
          ? data.soundVolume.value
          : this.soundVolume,
      notify: data.notify.present ? data.notify.value : this.notify,
      popup: data.popup.present ? data.popup.value : this.popup,
      snoozeMinutes: data.snoozeMinutes.present
          ? data.snoozeMinutes.value
          : this.snoozeMinutes,
      lastTriggeredAt: data.lastTriggeredAt.present
          ? data.lastTriggeredAt.value
          : this.lastTriggeredAt,
      nextTriggerAt: data.nextTriggerAt.present
          ? data.nextTriggerAt.value
          : this.nextTriggerAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimerTaskEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('message: $message, ')
          ..write('type: $type, ')
          ..write('enabled: $enabled, ')
          ..write('triggerAt: $triggerAt, ')
          ..write('countdownSeconds: $countdownSeconds, ')
          ..write('intervalSeconds: $intervalSeconds, ')
          ..write('dailyTimesJson: $dailyTimesJson, ')
          ..write('weekdaysJson: $weekdaysJson, ')
          ..write('activeStartMinutes: $activeStartMinutes, ')
          ..write('activeEndMinutes: $activeEndMinutes, ')
          ..write('endConditionType: $endConditionType, ')
          ..write('endDate: $endDate, ')
          ..write('endCount: $endCount, ')
          ..write('triggeredCount: $triggeredCount, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('soundId: $soundId, ')
          ..write('soundVolume: $soundVolume, ')
          ..write('notify: $notify, ')
          ..write('popup: $popup, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('nextTriggerAt: $nextTriggerAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    message,
    type,
    enabled,
    triggerAt,
    countdownSeconds,
    intervalSeconds,
    dailyTimesJson,
    weekdaysJson,
    activeStartMinutes,
    activeEndMinutes,
    endConditionType,
    endDate,
    endCount,
    triggeredCount,
    soundEnabled,
    soundId,
    soundVolume,
    notify,
    popup,
    snoozeMinutes,
    lastTriggeredAt,
    nextTriggerAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerTaskEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.message == this.message &&
          other.type == this.type &&
          other.enabled == this.enabled &&
          other.triggerAt == this.triggerAt &&
          other.countdownSeconds == this.countdownSeconds &&
          other.intervalSeconds == this.intervalSeconds &&
          other.dailyTimesJson == this.dailyTimesJson &&
          other.weekdaysJson == this.weekdaysJson &&
          other.activeStartMinutes == this.activeStartMinutes &&
          other.activeEndMinutes == this.activeEndMinutes &&
          other.endConditionType == this.endConditionType &&
          other.endDate == this.endDate &&
          other.endCount == this.endCount &&
          other.triggeredCount == this.triggeredCount &&
          other.soundEnabled == this.soundEnabled &&
          other.soundId == this.soundId &&
          other.soundVolume == this.soundVolume &&
          other.notify == this.notify &&
          other.popup == this.popup &&
          other.snoozeMinutes == this.snoozeMinutes &&
          other.lastTriggeredAt == this.lastTriggeredAt &&
          other.nextTriggerAt == this.nextTriggerAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TimerTasksTableCompanion extends UpdateCompanion<TimerTaskEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> message;
  final Value<String> type;
  final Value<bool> enabled;
  final Value<DateTime?> triggerAt;
  final Value<int?> countdownSeconds;
  final Value<int?> intervalSeconds;
  final Value<String?> dailyTimesJson;
  final Value<String?> weekdaysJson;
  final Value<int?> activeStartMinutes;
  final Value<int?> activeEndMinutes;
  final Value<String> endConditionType;
  final Value<DateTime?> endDate;
  final Value<int?> endCount;
  final Value<int> triggeredCount;
  final Value<bool> soundEnabled;
  final Value<String> soundId;
  final Value<double> soundVolume;
  final Value<bool> notify;
  final Value<bool> popup;
  final Value<int?> snoozeMinutes;
  final Value<DateTime?> lastTriggeredAt;
  final Value<DateTime?> nextTriggerAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TimerTasksTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.message = const Value.absent(),
    this.type = const Value.absent(),
    this.enabled = const Value.absent(),
    this.triggerAt = const Value.absent(),
    this.countdownSeconds = const Value.absent(),
    this.intervalSeconds = const Value.absent(),
    this.dailyTimesJson = const Value.absent(),
    this.weekdaysJson = const Value.absent(),
    this.activeStartMinutes = const Value.absent(),
    this.activeEndMinutes = const Value.absent(),
    this.endConditionType = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endCount = const Value.absent(),
    this.triggeredCount = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.soundId = const Value.absent(),
    this.soundVolume = const Value.absent(),
    this.notify = const Value.absent(),
    this.popup = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.nextTriggerAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimerTasksTableCompanion.insert({
    required String id,
    required String name,
    this.message = const Value.absent(),
    required String type,
    this.enabled = const Value.absent(),
    this.triggerAt = const Value.absent(),
    this.countdownSeconds = const Value.absent(),
    this.intervalSeconds = const Value.absent(),
    this.dailyTimesJson = const Value.absent(),
    this.weekdaysJson = const Value.absent(),
    this.activeStartMinutes = const Value.absent(),
    this.activeEndMinutes = const Value.absent(),
    this.endConditionType = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endCount = const Value.absent(),
    this.triggeredCount = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.soundId = const Value.absent(),
    this.soundVolume = const Value.absent(),
    this.notify = const Value.absent(),
    this.popup = const Value.absent(),
    this.snoozeMinutes = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.nextTriggerAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TimerTaskEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? message,
    Expression<String>? type,
    Expression<bool>? enabled,
    Expression<DateTime>? triggerAt,
    Expression<int>? countdownSeconds,
    Expression<int>? intervalSeconds,
    Expression<String>? dailyTimesJson,
    Expression<String>? weekdaysJson,
    Expression<int>? activeStartMinutes,
    Expression<int>? activeEndMinutes,
    Expression<String>? endConditionType,
    Expression<DateTime>? endDate,
    Expression<int>? endCount,
    Expression<int>? triggeredCount,
    Expression<bool>? soundEnabled,
    Expression<String>? soundId,
    Expression<double>? soundVolume,
    Expression<bool>? notify,
    Expression<bool>? popup,
    Expression<int>? snoozeMinutes,
    Expression<DateTime>? lastTriggeredAt,
    Expression<DateTime>? nextTriggerAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (message != null) 'message': message,
      if (type != null) 'type': type,
      if (enabled != null) 'enabled': enabled,
      if (triggerAt != null) 'trigger_at': triggerAt,
      if (countdownSeconds != null) 'countdown_seconds': countdownSeconds,
      if (intervalSeconds != null) 'interval_seconds': intervalSeconds,
      if (dailyTimesJson != null) 'daily_times_json': dailyTimesJson,
      if (weekdaysJson != null) 'weekdays_json': weekdaysJson,
      if (activeStartMinutes != null)
        'active_start_minutes': activeStartMinutes,
      if (activeEndMinutes != null) 'active_end_minutes': activeEndMinutes,
      if (endConditionType != null) 'end_condition_type': endConditionType,
      if (endDate != null) 'end_date': endDate,
      if (endCount != null) 'end_count': endCount,
      if (triggeredCount != null) 'triggered_count': triggeredCount,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (soundId != null) 'sound_id': soundId,
      if (soundVolume != null) 'sound_volume': soundVolume,
      if (notify != null) 'notify': notify,
      if (popup != null) 'popup': popup,
      if (snoozeMinutes != null) 'snooze_minutes': snoozeMinutes,
      if (lastTriggeredAt != null) 'last_triggered_at': lastTriggeredAt,
      if (nextTriggerAt != null) 'next_trigger_at': nextTriggerAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimerTasksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? message,
    Value<String>? type,
    Value<bool>? enabled,
    Value<DateTime?>? triggerAt,
    Value<int?>? countdownSeconds,
    Value<int?>? intervalSeconds,
    Value<String?>? dailyTimesJson,
    Value<String?>? weekdaysJson,
    Value<int?>? activeStartMinutes,
    Value<int?>? activeEndMinutes,
    Value<String>? endConditionType,
    Value<DateTime?>? endDate,
    Value<int?>? endCount,
    Value<int>? triggeredCount,
    Value<bool>? soundEnabled,
    Value<String>? soundId,
    Value<double>? soundVolume,
    Value<bool>? notify,
    Value<bool>? popup,
    Value<int?>? snoozeMinutes,
    Value<DateTime?>? lastTriggeredAt,
    Value<DateTime?>? nextTriggerAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TimerTasksTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      message: message ?? this.message,
      type: type ?? this.type,
      enabled: enabled ?? this.enabled,
      triggerAt: triggerAt ?? this.triggerAt,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      dailyTimesJson: dailyTimesJson ?? this.dailyTimesJson,
      weekdaysJson: weekdaysJson ?? this.weekdaysJson,
      activeStartMinutes: activeStartMinutes ?? this.activeStartMinutes,
      activeEndMinutes: activeEndMinutes ?? this.activeEndMinutes,
      endConditionType: endConditionType ?? this.endConditionType,
      endDate: endDate ?? this.endDate,
      endCount: endCount ?? this.endCount,
      triggeredCount: triggeredCount ?? this.triggeredCount,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      soundId: soundId ?? this.soundId,
      soundVolume: soundVolume ?? this.soundVolume,
      notify: notify ?? this.notify,
      popup: popup ?? this.popup,
      snoozeMinutes: snoozeMinutes ?? this.snoozeMinutes,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      nextTriggerAt: nextTriggerAt ?? this.nextTriggerAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (triggerAt.present) {
      map['trigger_at'] = Variable<DateTime>(triggerAt.value);
    }
    if (countdownSeconds.present) {
      map['countdown_seconds'] = Variable<int>(countdownSeconds.value);
    }
    if (intervalSeconds.present) {
      map['interval_seconds'] = Variable<int>(intervalSeconds.value);
    }
    if (dailyTimesJson.present) {
      map['daily_times_json'] = Variable<String>(dailyTimesJson.value);
    }
    if (weekdaysJson.present) {
      map['weekdays_json'] = Variable<String>(weekdaysJson.value);
    }
    if (activeStartMinutes.present) {
      map['active_start_minutes'] = Variable<int>(activeStartMinutes.value);
    }
    if (activeEndMinutes.present) {
      map['active_end_minutes'] = Variable<int>(activeEndMinutes.value);
    }
    if (endConditionType.present) {
      map['end_condition_type'] = Variable<String>(endConditionType.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (endCount.present) {
      map['end_count'] = Variable<int>(endCount.value);
    }
    if (triggeredCount.present) {
      map['triggered_count'] = Variable<int>(triggeredCount.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (soundVolume.present) {
      map['sound_volume'] = Variable<double>(soundVolume.value);
    }
    if (notify.present) {
      map['notify'] = Variable<bool>(notify.value);
    }
    if (popup.present) {
      map['popup'] = Variable<bool>(popup.value);
    }
    if (snoozeMinutes.present) {
      map['snooze_minutes'] = Variable<int>(snoozeMinutes.value);
    }
    if (lastTriggeredAt.present) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt.value);
    }
    if (nextTriggerAt.present) {
      map['next_trigger_at'] = Variable<DateTime>(nextTriggerAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimerTasksTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('message: $message, ')
          ..write('type: $type, ')
          ..write('enabled: $enabled, ')
          ..write('triggerAt: $triggerAt, ')
          ..write('countdownSeconds: $countdownSeconds, ')
          ..write('intervalSeconds: $intervalSeconds, ')
          ..write('dailyTimesJson: $dailyTimesJson, ')
          ..write('weekdaysJson: $weekdaysJson, ')
          ..write('activeStartMinutes: $activeStartMinutes, ')
          ..write('activeEndMinutes: $activeEndMinutes, ')
          ..write('endConditionType: $endConditionType, ')
          ..write('endDate: $endDate, ')
          ..write('endCount: $endCount, ')
          ..write('triggeredCount: $triggeredCount, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('soundId: $soundId, ')
          ..write('soundVolume: $soundVolume, ')
          ..write('notify: $notify, ')
          ..write('popup: $popup, ')
          ..write('snoozeMinutes: $snoozeMinutes, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('nextTriggerAt: $nextTriggerAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startOnLoginMeta = const VerificationMeta(
    'startOnLogin',
  );
  @override
  late final GeneratedColumn<bool> startOnLogin = GeneratedColumn<bool>(
    'start_on_login',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("start_on_login" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _minimizeToTrayOnCloseMeta =
      const VerificationMeta('minimizeToTrayOnClose');
  @override
  late final GeneratedColumn<bool> minimizeToTrayOnClose =
      GeneratedColumn<bool>(
        'minimize_to_tray_on_close',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("minimize_to_tray_on_close" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _defaultNotifyMeta = const VerificationMeta(
    'defaultNotify',
  );
  @override
  late final GeneratedColumn<bool> defaultNotify = GeneratedColumn<bool>(
    'default_notify',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("default_notify" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultSoundMeta = const VerificationMeta(
    'defaultSound',
  );
  @override
  late final GeneratedColumn<bool> defaultSound = GeneratedColumn<bool>(
    'default_sound',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("default_sound" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _defaultVolumeMeta = const VerificationMeta(
    'defaultVolume',
  );
  @override
  late final GeneratedColumn<double> defaultVolume = GeneratedColumn<double>(
    'default_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _defaultSoundIdMeta = const VerificationMeta(
    'defaultSoundId',
  );
  @override
  late final GeneratedColumn<String> defaultSoundId = GeneratedColumn<String>(
    'default_sound_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _dndEnabledMeta = const VerificationMeta(
    'dndEnabled',
  );
  @override
  late final GeneratedColumn<bool> dndEnabled = GeneratedColumn<bool>(
    'dnd_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("dnd_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dndStartMinutesMeta = const VerificationMeta(
    'dndStartMinutes',
  );
  @override
  late final GeneratedColumn<int> dndStartMinutes = GeneratedColumn<int>(
    'dnd_start_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dndEndMinutesMeta = const VerificationMeta(
    'dndEndMinutes',
  );
  @override
  late final GeneratedColumn<int> dndEndMinutes = GeneratedColumn<int>(
    'dnd_end_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startOnLogin,
    minimizeToTrayOnClose,
    defaultNotify,
    defaultSound,
    defaultVolume,
    defaultSoundId,
    dndEnabled,
    dndStartMinutes,
    dndEndMinutes,
    themeMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingsEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_on_login')) {
      context.handle(
        _startOnLoginMeta,
        startOnLogin.isAcceptableOrUnknown(
          data['start_on_login']!,
          _startOnLoginMeta,
        ),
      );
    }
    if (data.containsKey('minimize_to_tray_on_close')) {
      context.handle(
        _minimizeToTrayOnCloseMeta,
        minimizeToTrayOnClose.isAcceptableOrUnknown(
          data['minimize_to_tray_on_close']!,
          _minimizeToTrayOnCloseMeta,
        ),
      );
    }
    if (data.containsKey('default_notify')) {
      context.handle(
        _defaultNotifyMeta,
        defaultNotify.isAcceptableOrUnknown(
          data['default_notify']!,
          _defaultNotifyMeta,
        ),
      );
    }
    if (data.containsKey('default_sound')) {
      context.handle(
        _defaultSoundMeta,
        defaultSound.isAcceptableOrUnknown(
          data['default_sound']!,
          _defaultSoundMeta,
        ),
      );
    }
    if (data.containsKey('default_volume')) {
      context.handle(
        _defaultVolumeMeta,
        defaultVolume.isAcceptableOrUnknown(
          data['default_volume']!,
          _defaultVolumeMeta,
        ),
      );
    }
    if (data.containsKey('default_sound_id')) {
      context.handle(
        _defaultSoundIdMeta,
        defaultSoundId.isAcceptableOrUnknown(
          data['default_sound_id']!,
          _defaultSoundIdMeta,
        ),
      );
    }
    if (data.containsKey('dnd_enabled')) {
      context.handle(
        _dndEnabledMeta,
        dndEnabled.isAcceptableOrUnknown(data['dnd_enabled']!, _dndEnabledMeta),
      );
    }
    if (data.containsKey('dnd_start_minutes')) {
      context.handle(
        _dndStartMinutesMeta,
        dndStartMinutes.isAcceptableOrUnknown(
          data['dnd_start_minutes']!,
          _dndStartMinutesMeta,
        ),
      );
    }
    if (data.containsKey('dnd_end_minutes')) {
      context.handle(
        _dndEndMinutesMeta,
        dndEndMinutes.isAcceptableOrUnknown(
          data['dnd_end_minutes']!,
          _dndEndMinutesMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startOnLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}start_on_login'],
      )!,
      minimizeToTrayOnClose: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}minimize_to_tray_on_close'],
      )!,
      defaultNotify: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}default_notify'],
      )!,
      defaultSound: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}default_sound'],
      )!,
      defaultVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_volume'],
      )!,
      defaultSoundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_sound_id'],
      )!,
      dndEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dnd_enabled'],
      )!,
      dndStartMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dnd_start_minutes'],
      ),
      dndEndMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dnd_end_minutes'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsEntity extends DataClass
    implements Insertable<AppSettingsEntity> {
  final int id;
  final bool startOnLogin;
  final bool minimizeToTrayOnClose;
  final bool defaultNotify;
  final bool defaultSound;
  final double defaultVolume;
  final String defaultSoundId;
  final bool dndEnabled;
  final int? dndStartMinutes;
  final int? dndEndMinutes;

  /// ThemeMode 的枚举名（system/light/dark）。
  final String themeMode;
  const AppSettingsEntity({
    required this.id,
    required this.startOnLogin,
    required this.minimizeToTrayOnClose,
    required this.defaultNotify,
    required this.defaultSound,
    required this.defaultVolume,
    required this.defaultSoundId,
    required this.dndEnabled,
    this.dndStartMinutes,
    this.dndEndMinutes,
    required this.themeMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start_on_login'] = Variable<bool>(startOnLogin);
    map['minimize_to_tray_on_close'] = Variable<bool>(minimizeToTrayOnClose);
    map['default_notify'] = Variable<bool>(defaultNotify);
    map['default_sound'] = Variable<bool>(defaultSound);
    map['default_volume'] = Variable<double>(defaultVolume);
    map['default_sound_id'] = Variable<String>(defaultSoundId);
    map['dnd_enabled'] = Variable<bool>(dndEnabled);
    if (!nullToAbsent || dndStartMinutes != null) {
      map['dnd_start_minutes'] = Variable<int>(dndStartMinutes);
    }
    if (!nullToAbsent || dndEndMinutes != null) {
      map['dnd_end_minutes'] = Variable<int>(dndEndMinutes);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      id: Value(id),
      startOnLogin: Value(startOnLogin),
      minimizeToTrayOnClose: Value(minimizeToTrayOnClose),
      defaultNotify: Value(defaultNotify),
      defaultSound: Value(defaultSound),
      defaultVolume: Value(defaultVolume),
      defaultSoundId: Value(defaultSoundId),
      dndEnabled: Value(dndEnabled),
      dndStartMinutes: dndStartMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(dndStartMinutes),
      dndEndMinutes: dndEndMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(dndEndMinutes),
      themeMode: Value(themeMode),
    );
  }

  factory AppSettingsEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsEntity(
      id: serializer.fromJson<int>(json['id']),
      startOnLogin: serializer.fromJson<bool>(json['startOnLogin']),
      minimizeToTrayOnClose: serializer.fromJson<bool>(
        json['minimizeToTrayOnClose'],
      ),
      defaultNotify: serializer.fromJson<bool>(json['defaultNotify']),
      defaultSound: serializer.fromJson<bool>(json['defaultSound']),
      defaultVolume: serializer.fromJson<double>(json['defaultVolume']),
      defaultSoundId: serializer.fromJson<String>(json['defaultSoundId']),
      dndEnabled: serializer.fromJson<bool>(json['dndEnabled']),
      dndStartMinutes: serializer.fromJson<int?>(json['dndStartMinutes']),
      dndEndMinutes: serializer.fromJson<int?>(json['dndEndMinutes']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startOnLogin': serializer.toJson<bool>(startOnLogin),
      'minimizeToTrayOnClose': serializer.toJson<bool>(minimizeToTrayOnClose),
      'defaultNotify': serializer.toJson<bool>(defaultNotify),
      'defaultSound': serializer.toJson<bool>(defaultSound),
      'defaultVolume': serializer.toJson<double>(defaultVolume),
      'defaultSoundId': serializer.toJson<String>(defaultSoundId),
      'dndEnabled': serializer.toJson<bool>(dndEnabled),
      'dndStartMinutes': serializer.toJson<int?>(dndStartMinutes),
      'dndEndMinutes': serializer.toJson<int?>(dndEndMinutes),
      'themeMode': serializer.toJson<String>(themeMode),
    };
  }

  AppSettingsEntity copyWith({
    int? id,
    bool? startOnLogin,
    bool? minimizeToTrayOnClose,
    bool? defaultNotify,
    bool? defaultSound,
    double? defaultVolume,
    String? defaultSoundId,
    bool? dndEnabled,
    Value<int?> dndStartMinutes = const Value.absent(),
    Value<int?> dndEndMinutes = const Value.absent(),
    String? themeMode,
  }) => AppSettingsEntity(
    id: id ?? this.id,
    startOnLogin: startOnLogin ?? this.startOnLogin,
    minimizeToTrayOnClose: minimizeToTrayOnClose ?? this.minimizeToTrayOnClose,
    defaultNotify: defaultNotify ?? this.defaultNotify,
    defaultSound: defaultSound ?? this.defaultSound,
    defaultVolume: defaultVolume ?? this.defaultVolume,
    defaultSoundId: defaultSoundId ?? this.defaultSoundId,
    dndEnabled: dndEnabled ?? this.dndEnabled,
    dndStartMinutes: dndStartMinutes.present
        ? dndStartMinutes.value
        : this.dndStartMinutes,
    dndEndMinutes: dndEndMinutes.present
        ? dndEndMinutes.value
        : this.dndEndMinutes,
    themeMode: themeMode ?? this.themeMode,
  );
  AppSettingsEntity copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsEntity(
      id: data.id.present ? data.id.value : this.id,
      startOnLogin: data.startOnLogin.present
          ? data.startOnLogin.value
          : this.startOnLogin,
      minimizeToTrayOnClose: data.minimizeToTrayOnClose.present
          ? data.minimizeToTrayOnClose.value
          : this.minimizeToTrayOnClose,
      defaultNotify: data.defaultNotify.present
          ? data.defaultNotify.value
          : this.defaultNotify,
      defaultSound: data.defaultSound.present
          ? data.defaultSound.value
          : this.defaultSound,
      defaultVolume: data.defaultVolume.present
          ? data.defaultVolume.value
          : this.defaultVolume,
      defaultSoundId: data.defaultSoundId.present
          ? data.defaultSoundId.value
          : this.defaultSoundId,
      dndEnabled: data.dndEnabled.present
          ? data.dndEnabled.value
          : this.dndEnabled,
      dndStartMinutes: data.dndStartMinutes.present
          ? data.dndStartMinutes.value
          : this.dndStartMinutes,
      dndEndMinutes: data.dndEndMinutes.present
          ? data.dndEndMinutes.value
          : this.dndEndMinutes,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsEntity(')
          ..write('id: $id, ')
          ..write('startOnLogin: $startOnLogin, ')
          ..write('minimizeToTrayOnClose: $minimizeToTrayOnClose, ')
          ..write('defaultNotify: $defaultNotify, ')
          ..write('defaultSound: $defaultSound, ')
          ..write('defaultVolume: $defaultVolume, ')
          ..write('defaultSoundId: $defaultSoundId, ')
          ..write('dndEnabled: $dndEnabled, ')
          ..write('dndStartMinutes: $dndStartMinutes, ')
          ..write('dndEndMinutes: $dndEndMinutes, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startOnLogin,
    minimizeToTrayOnClose,
    defaultNotify,
    defaultSound,
    defaultVolume,
    defaultSoundId,
    dndEnabled,
    dndStartMinutes,
    dndEndMinutes,
    themeMode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsEntity &&
          other.id == this.id &&
          other.startOnLogin == this.startOnLogin &&
          other.minimizeToTrayOnClose == this.minimizeToTrayOnClose &&
          other.defaultNotify == this.defaultNotify &&
          other.defaultSound == this.defaultSound &&
          other.defaultVolume == this.defaultVolume &&
          other.defaultSoundId == this.defaultSoundId &&
          other.dndEnabled == this.dndEnabled &&
          other.dndStartMinutes == this.dndStartMinutes &&
          other.dndEndMinutes == this.dndEndMinutes &&
          other.themeMode == this.themeMode);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsEntity> {
  final Value<int> id;
  final Value<bool> startOnLogin;
  final Value<bool> minimizeToTrayOnClose;
  final Value<bool> defaultNotify;
  final Value<bool> defaultSound;
  final Value<double> defaultVolume;
  final Value<String> defaultSoundId;
  final Value<bool> dndEnabled;
  final Value<int?> dndStartMinutes;
  final Value<int?> dndEndMinutes;
  final Value<String> themeMode;
  const AppSettingsTableCompanion({
    this.id = const Value.absent(),
    this.startOnLogin = const Value.absent(),
    this.minimizeToTrayOnClose = const Value.absent(),
    this.defaultNotify = const Value.absent(),
    this.defaultSound = const Value.absent(),
    this.defaultVolume = const Value.absent(),
    this.defaultSoundId = const Value.absent(),
    this.dndEnabled = const Value.absent(),
    this.dndStartMinutes = const Value.absent(),
    this.dndEndMinutes = const Value.absent(),
    this.themeMode = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.startOnLogin = const Value.absent(),
    this.minimizeToTrayOnClose = const Value.absent(),
    this.defaultNotify = const Value.absent(),
    this.defaultSound = const Value.absent(),
    this.defaultVolume = const Value.absent(),
    this.defaultSoundId = const Value.absent(),
    this.dndEnabled = const Value.absent(),
    this.dndStartMinutes = const Value.absent(),
    this.dndEndMinutes = const Value.absent(),
    this.themeMode = const Value.absent(),
  });
  static Insertable<AppSettingsEntity> custom({
    Expression<int>? id,
    Expression<bool>? startOnLogin,
    Expression<bool>? minimizeToTrayOnClose,
    Expression<bool>? defaultNotify,
    Expression<bool>? defaultSound,
    Expression<double>? defaultVolume,
    Expression<String>? defaultSoundId,
    Expression<bool>? dndEnabled,
    Expression<int>? dndStartMinutes,
    Expression<int>? dndEndMinutes,
    Expression<String>? themeMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startOnLogin != null) 'start_on_login': startOnLogin,
      if (minimizeToTrayOnClose != null)
        'minimize_to_tray_on_close': minimizeToTrayOnClose,
      if (defaultNotify != null) 'default_notify': defaultNotify,
      if (defaultSound != null) 'default_sound': defaultSound,
      if (defaultVolume != null) 'default_volume': defaultVolume,
      if (defaultSoundId != null) 'default_sound_id': defaultSoundId,
      if (dndEnabled != null) 'dnd_enabled': dndEnabled,
      if (dndStartMinutes != null) 'dnd_start_minutes': dndStartMinutes,
      if (dndEndMinutes != null) 'dnd_end_minutes': dndEndMinutes,
      if (themeMode != null) 'theme_mode': themeMode,
    });
  }

  AppSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<bool>? startOnLogin,
    Value<bool>? minimizeToTrayOnClose,
    Value<bool>? defaultNotify,
    Value<bool>? defaultSound,
    Value<double>? defaultVolume,
    Value<String>? defaultSoundId,
    Value<bool>? dndEnabled,
    Value<int?>? dndStartMinutes,
    Value<int?>? dndEndMinutes,
    Value<String>? themeMode,
  }) {
    return AppSettingsTableCompanion(
      id: id ?? this.id,
      startOnLogin: startOnLogin ?? this.startOnLogin,
      minimizeToTrayOnClose:
          minimizeToTrayOnClose ?? this.minimizeToTrayOnClose,
      defaultNotify: defaultNotify ?? this.defaultNotify,
      defaultSound: defaultSound ?? this.defaultSound,
      defaultVolume: defaultVolume ?? this.defaultVolume,
      defaultSoundId: defaultSoundId ?? this.defaultSoundId,
      dndEnabled: dndEnabled ?? this.dndEnabled,
      dndStartMinutes: dndStartMinutes ?? this.dndStartMinutes,
      dndEndMinutes: dndEndMinutes ?? this.dndEndMinutes,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startOnLogin.present) {
      map['start_on_login'] = Variable<bool>(startOnLogin.value);
    }
    if (minimizeToTrayOnClose.present) {
      map['minimize_to_tray_on_close'] = Variable<bool>(
        minimizeToTrayOnClose.value,
      );
    }
    if (defaultNotify.present) {
      map['default_notify'] = Variable<bool>(defaultNotify.value);
    }
    if (defaultSound.present) {
      map['default_sound'] = Variable<bool>(defaultSound.value);
    }
    if (defaultVolume.present) {
      map['default_volume'] = Variable<double>(defaultVolume.value);
    }
    if (defaultSoundId.present) {
      map['default_sound_id'] = Variable<String>(defaultSoundId.value);
    }
    if (dndEnabled.present) {
      map['dnd_enabled'] = Variable<bool>(dndEnabled.value);
    }
    if (dndStartMinutes.present) {
      map['dnd_start_minutes'] = Variable<int>(dndStartMinutes.value);
    }
    if (dndEndMinutes.present) {
      map['dnd_end_minutes'] = Variable<int>(dndEndMinutes.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('startOnLogin: $startOnLogin, ')
          ..write('minimizeToTrayOnClose: $minimizeToTrayOnClose, ')
          ..write('defaultNotify: $defaultNotify, ')
          ..write('defaultSound: $defaultSound, ')
          ..write('defaultVolume: $defaultVolume, ')
          ..write('defaultSoundId: $defaultSoundId, ')
          ..write('dndEnabled: $dndEnabled, ')
          ..write('dndStartMinutes: $dndStartMinutes, ')
          ..write('dndEndMinutes: $dndEndMinutes, ')
          ..write('themeMode: $themeMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TimerTasksTableTable timerTasksTable = $TimerTasksTableTable(
    this,
  );
  late final $AppSettingsTableTable appSettingsTable = $AppSettingsTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    timerTasksTable,
    appSettingsTable,
  ];
}

typedef $$TimerTasksTableTableCreateCompanionBuilder =
    TimerTasksTableCompanion Function({
      required String id,
      required String name,
      Value<String> message,
      required String type,
      Value<bool> enabled,
      Value<DateTime?> triggerAt,
      Value<int?> countdownSeconds,
      Value<int?> intervalSeconds,
      Value<String?> dailyTimesJson,
      Value<String?> weekdaysJson,
      Value<int?> activeStartMinutes,
      Value<int?> activeEndMinutes,
      Value<String> endConditionType,
      Value<DateTime?> endDate,
      Value<int?> endCount,
      Value<int> triggeredCount,
      Value<bool> soundEnabled,
      Value<String> soundId,
      Value<double> soundVolume,
      Value<bool> notify,
      Value<bool> popup,
      Value<int?> snoozeMinutes,
      Value<DateTime?> lastTriggeredAt,
      Value<DateTime?> nextTriggerAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TimerTasksTableTableUpdateCompanionBuilder =
    TimerTasksTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> message,
      Value<String> type,
      Value<bool> enabled,
      Value<DateTime?> triggerAt,
      Value<int?> countdownSeconds,
      Value<int?> intervalSeconds,
      Value<String?> dailyTimesJson,
      Value<String?> weekdaysJson,
      Value<int?> activeStartMinutes,
      Value<int?> activeEndMinutes,
      Value<String> endConditionType,
      Value<DateTime?> endDate,
      Value<int?> endCount,
      Value<int> triggeredCount,
      Value<bool> soundEnabled,
      Value<String> soundId,
      Value<double> soundVolume,
      Value<bool> notify,
      Value<bool> popup,
      Value<int?> snoozeMinutes,
      Value<DateTime?> lastTriggeredAt,
      Value<DateTime?> nextTriggerAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TimerTasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TimerTasksTableTable> {
  $$TimerTasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get triggerAt => $composableBuilder(
    column: $table.triggerAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dailyTimesJson => $composableBuilder(
    column: $table.dailyTimesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeStartMinutes => $composableBuilder(
    column: $table.activeStartMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeEndMinutes => $composableBuilder(
    column: $table.activeEndMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endConditionType => $composableBuilder(
    column: $table.endConditionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endCount => $composableBuilder(
    column: $table.endCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get triggeredCount => $composableBuilder(
    column: $table.triggeredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notify => $composableBuilder(
    column: $table.notify,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get popup => $composableBuilder(
    column: $table.popup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimerTasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TimerTasksTableTable> {
  $$TimerTasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get triggerAt => $composableBuilder(
    column: $table.triggerAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dailyTimesJson => $composableBuilder(
    column: $table.dailyTimesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeStartMinutes => $composableBuilder(
    column: $table.activeStartMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeEndMinutes => $composableBuilder(
    column: $table.activeEndMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endConditionType => $composableBuilder(
    column: $table.endConditionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endCount => $composableBuilder(
    column: $table.endCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get triggeredCount => $composableBuilder(
    column: $table.triggeredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get soundId => $composableBuilder(
    column: $table.soundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notify => $composableBuilder(
    column: $table.notify,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get popup => $composableBuilder(
    column: $table.popup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimerTasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimerTasksTableTable> {
  $$TimerTasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<DateTime> get triggerAt =>
      $composableBuilder(column: $table.triggerAt, builder: (column) => column);

  GeneratedColumn<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalSeconds => $composableBuilder(
    column: $table.intervalSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dailyTimesJson => $composableBuilder(
    column: $table.dailyTimesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weekdaysJson => $composableBuilder(
    column: $table.weekdaysJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activeStartMinutes => $composableBuilder(
    column: $table.activeStartMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activeEndMinutes => $composableBuilder(
    column: $table.activeEndMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endConditionType => $composableBuilder(
    column: $table.endConditionType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get endCount =>
      $composableBuilder(column: $table.endCount, builder: (column) => column);

  GeneratedColumn<int> get triggeredCount => $composableBuilder(
    column: $table.triggeredCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<double> get soundVolume => $composableBuilder(
    column: $table.soundVolume,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notify =>
      $composableBuilder(column: $table.notify, builder: (column) => column);

  GeneratedColumn<bool> get popup =>
      $composableBuilder(column: $table.popup, builder: (column) => column);

  GeneratedColumn<int> get snoozeMinutes => $composableBuilder(
    column: $table.snoozeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextTriggerAt => $composableBuilder(
    column: $table.nextTriggerAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TimerTasksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimerTasksTableTable,
          TimerTaskEntity,
          $$TimerTasksTableTableFilterComposer,
          $$TimerTasksTableTableOrderingComposer,
          $$TimerTasksTableTableAnnotationComposer,
          $$TimerTasksTableTableCreateCompanionBuilder,
          $$TimerTasksTableTableUpdateCompanionBuilder,
          (
            TimerTaskEntity,
            BaseReferences<
              _$AppDatabase,
              $TimerTasksTableTable,
              TimerTaskEntity
            >,
          ),
          TimerTaskEntity,
          PrefetchHooks Function()
        > {
  $$TimerTasksTableTableTableManager(
    _$AppDatabase db,
    $TimerTasksTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimerTasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimerTasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimerTasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<DateTime?> triggerAt = const Value.absent(),
                Value<int?> countdownSeconds = const Value.absent(),
                Value<int?> intervalSeconds = const Value.absent(),
                Value<String?> dailyTimesJson = const Value.absent(),
                Value<String?> weekdaysJson = const Value.absent(),
                Value<int?> activeStartMinutes = const Value.absent(),
                Value<int?> activeEndMinutes = const Value.absent(),
                Value<String> endConditionType = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> endCount = const Value.absent(),
                Value<int> triggeredCount = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<double> soundVolume = const Value.absent(),
                Value<bool> notify = const Value.absent(),
                Value<bool> popup = const Value.absent(),
                Value<int?> snoozeMinutes = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                Value<DateTime?> nextTriggerAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimerTasksTableCompanion(
                id: id,
                name: name,
                message: message,
                type: type,
                enabled: enabled,
                triggerAt: triggerAt,
                countdownSeconds: countdownSeconds,
                intervalSeconds: intervalSeconds,
                dailyTimesJson: dailyTimesJson,
                weekdaysJson: weekdaysJson,
                activeStartMinutes: activeStartMinutes,
                activeEndMinutes: activeEndMinutes,
                endConditionType: endConditionType,
                endDate: endDate,
                endCount: endCount,
                triggeredCount: triggeredCount,
                soundEnabled: soundEnabled,
                soundId: soundId,
                soundVolume: soundVolume,
                notify: notify,
                popup: popup,
                snoozeMinutes: snoozeMinutes,
                lastTriggeredAt: lastTriggeredAt,
                nextTriggerAt: nextTriggerAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String> message = const Value.absent(),
                required String type,
                Value<bool> enabled = const Value.absent(),
                Value<DateTime?> triggerAt = const Value.absent(),
                Value<int?> countdownSeconds = const Value.absent(),
                Value<int?> intervalSeconds = const Value.absent(),
                Value<String?> dailyTimesJson = const Value.absent(),
                Value<String?> weekdaysJson = const Value.absent(),
                Value<int?> activeStartMinutes = const Value.absent(),
                Value<int?> activeEndMinutes = const Value.absent(),
                Value<String> endConditionType = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> endCount = const Value.absent(),
                Value<int> triggeredCount = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<String> soundId = const Value.absent(),
                Value<double> soundVolume = const Value.absent(),
                Value<bool> notify = const Value.absent(),
                Value<bool> popup = const Value.absent(),
                Value<int?> snoozeMinutes = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                Value<DateTime?> nextTriggerAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TimerTasksTableCompanion.insert(
                id: id,
                name: name,
                message: message,
                type: type,
                enabled: enabled,
                triggerAt: triggerAt,
                countdownSeconds: countdownSeconds,
                intervalSeconds: intervalSeconds,
                dailyTimesJson: dailyTimesJson,
                weekdaysJson: weekdaysJson,
                activeStartMinutes: activeStartMinutes,
                activeEndMinutes: activeEndMinutes,
                endConditionType: endConditionType,
                endDate: endDate,
                endCount: endCount,
                triggeredCount: triggeredCount,
                soundEnabled: soundEnabled,
                soundId: soundId,
                soundVolume: soundVolume,
                notify: notify,
                popup: popup,
                snoozeMinutes: snoozeMinutes,
                lastTriggeredAt: lastTriggeredAt,
                nextTriggerAt: nextTriggerAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimerTasksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimerTasksTableTable,
      TimerTaskEntity,
      $$TimerTasksTableTableFilterComposer,
      $$TimerTasksTableTableOrderingComposer,
      $$TimerTasksTableTableAnnotationComposer,
      $$TimerTasksTableTableCreateCompanionBuilder,
      $$TimerTasksTableTableUpdateCompanionBuilder,
      (
        TimerTaskEntity,
        BaseReferences<_$AppDatabase, $TimerTasksTableTable, TimerTaskEntity>,
      ),
      TimerTaskEntity,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableTableCreateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<bool> startOnLogin,
      Value<bool> minimizeToTrayOnClose,
      Value<bool> defaultNotify,
      Value<bool> defaultSound,
      Value<double> defaultVolume,
      Value<String> defaultSoundId,
      Value<bool> dndEnabled,
      Value<int?> dndStartMinutes,
      Value<int?> dndEndMinutes,
      Value<String> themeMode,
    });
typedef $$AppSettingsTableTableUpdateCompanionBuilder =
    AppSettingsTableCompanion Function({
      Value<int> id,
      Value<bool> startOnLogin,
      Value<bool> minimizeToTrayOnClose,
      Value<bool> defaultNotify,
      Value<bool> defaultSound,
      Value<double> defaultVolume,
      Value<String> defaultSoundId,
      Value<bool> dndEnabled,
      Value<int?> dndStartMinutes,
      Value<int?> dndEndMinutes,
      Value<String> themeMode,
    });

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get startOnLogin => $composableBuilder(
    column: $table.startOnLogin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get minimizeToTrayOnClose => $composableBuilder(
    column: $table.minimizeToTrayOnClose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get defaultNotify => $composableBuilder(
    column: $table.defaultNotify,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get defaultSound => $composableBuilder(
    column: $table.defaultSound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultVolume => $composableBuilder(
    column: $table.defaultVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultSoundId => $composableBuilder(
    column: $table.defaultSoundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dndEnabled => $composableBuilder(
    column: $table.dndEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dndStartMinutes => $composableBuilder(
    column: $table.dndStartMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dndEndMinutes => $composableBuilder(
    column: $table.dndEndMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get startOnLogin => $composableBuilder(
    column: $table.startOnLogin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get minimizeToTrayOnClose => $composableBuilder(
    column: $table.minimizeToTrayOnClose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get defaultNotify => $composableBuilder(
    column: $table.defaultNotify,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get defaultSound => $composableBuilder(
    column: $table.defaultSound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultVolume => $composableBuilder(
    column: $table.defaultVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSoundId => $composableBuilder(
    column: $table.defaultSoundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dndEnabled => $composableBuilder(
    column: $table.dndEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dndStartMinutes => $composableBuilder(
    column: $table.dndStartMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dndEndMinutes => $composableBuilder(
    column: $table.dndEndMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get startOnLogin => $composableBuilder(
    column: $table.startOnLogin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get minimizeToTrayOnClose => $composableBuilder(
    column: $table.minimizeToTrayOnClose,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get defaultNotify => $composableBuilder(
    column: $table.defaultNotify,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get defaultSound => $composableBuilder(
    column: $table.defaultSound,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultVolume => $composableBuilder(
    column: $table.defaultVolume,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultSoundId => $composableBuilder(
    column: $table.defaultSoundId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get dndEnabled => $composableBuilder(
    column: $table.dndEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dndStartMinutes => $composableBuilder(
    column: $table.dndStartMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dndEndMinutes => $composableBuilder(
    column: $table.dndEndMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsEntity,
          $$AppSettingsTableTableFilterComposer,
          $$AppSettingsTableTableOrderingComposer,
          $$AppSettingsTableTableAnnotationComposer,
          $$AppSettingsTableTableCreateCompanionBuilder,
          $$AppSettingsTableTableUpdateCompanionBuilder,
          (
            AppSettingsEntity,
            BaseReferences<
              _$AppDatabase,
              $AppSettingsTableTable,
              AppSettingsEntity
            >,
          ),
          AppSettingsEntity,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableTableManager(
    _$AppDatabase db,
    $AppSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> startOnLogin = const Value.absent(),
                Value<bool> minimizeToTrayOnClose = const Value.absent(),
                Value<bool> defaultNotify = const Value.absent(),
                Value<bool> defaultSound = const Value.absent(),
                Value<double> defaultVolume = const Value.absent(),
                Value<String> defaultSoundId = const Value.absent(),
                Value<bool> dndEnabled = const Value.absent(),
                Value<int?> dndStartMinutes = const Value.absent(),
                Value<int?> dndEndMinutes = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
              }) => AppSettingsTableCompanion(
                id: id,
                startOnLogin: startOnLogin,
                minimizeToTrayOnClose: minimizeToTrayOnClose,
                defaultNotify: defaultNotify,
                defaultSound: defaultSound,
                defaultVolume: defaultVolume,
                defaultSoundId: defaultSoundId,
                dndEnabled: dndEnabled,
                dndStartMinutes: dndStartMinutes,
                dndEndMinutes: dndEndMinutes,
                themeMode: themeMode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> startOnLogin = const Value.absent(),
                Value<bool> minimizeToTrayOnClose = const Value.absent(),
                Value<bool> defaultNotify = const Value.absent(),
                Value<bool> defaultSound = const Value.absent(),
                Value<double> defaultVolume = const Value.absent(),
                Value<String> defaultSoundId = const Value.absent(),
                Value<bool> dndEnabled = const Value.absent(),
                Value<int?> dndStartMinutes = const Value.absent(),
                Value<int?> dndEndMinutes = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
              }) => AppSettingsTableCompanion.insert(
                id: id,
                startOnLogin: startOnLogin,
                minimizeToTrayOnClose: minimizeToTrayOnClose,
                defaultNotify: defaultNotify,
                defaultSound: defaultSound,
                defaultVolume: defaultVolume,
                defaultSoundId: defaultSoundId,
                dndEnabled: dndEnabled,
                dndStartMinutes: dndStartMinutes,
                dndEndMinutes: dndEndMinutes,
                themeMode: themeMode,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTableTable,
      AppSettingsEntity,
      $$AppSettingsTableTableFilterComposer,
      $$AppSettingsTableTableOrderingComposer,
      $$AppSettingsTableTableAnnotationComposer,
      $$AppSettingsTableTableCreateCompanionBuilder,
      $$AppSettingsTableTableUpdateCompanionBuilder,
      (
        AppSettingsEntity,
        BaseReferences<
          _$AppDatabase,
          $AppSettingsTableTable,
          AppSettingsEntity
        >,
      ),
      AppSettingsEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TimerTasksTableTableTableManager get timerTasksTable =>
      $$TimerTasksTableTableTableManager(_db, _db.timerTasksTable);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
}
