import 'package:intl/intl.dart';

// 使用纯数字 + 中文字面量的 pattern，避免依赖 intl 的 locale 名称数据
// （月份/星期英文名），因此无需额外调用 initializeDateFormatting。
final DateFormat _fullFormat = DateFormat('yyyy年MM月dd日 HH:mm:ss');
final DateFormat _dateFormat = DateFormat('yyyy年MM月dd日');
final DateFormat _shortFormat = DateFormat('MM月dd日 HH:mm');
final DateFormat _timeFormat = DateFormat('HH:mm');

const List<String> weekdayLabels = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
const List<String> weekdayShortLabels = ['一', '二', '三', '四', '五', '六', '日'];

String formatFullDateTime(DateTime dt) => _fullFormat.format(dt);

String formatDate(DateTime dt) => _dateFormat.format(dt);

String formatShortDateTime(DateTime dt) => _shortFormat.format(dt);

String formatTime(DateTime dt) => _timeFormat.format(dt);

String formatTimeOfDay(int hour, int minute) {
  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

/// 用于列表项展示的"下一次触发"友好描述。
String formatNextTrigger(DateTime? next, {required bool enabled, DateTime? now}) {
  if (!enabled) return '已暂停';
  if (next == null) return '已完成';
  final current = now ?? DateTime.now();
  final diff = next.difference(current);
  if (diff.isNegative) return '即将触发';
  if (diff.inDays >= 1) return formatShortDateTime(next);
  if (diff.inHours >= 1) return '${diff.inHours} 小时后 · ${formatTime(next)}';
  if (diff.inMinutes >= 1) return '${diff.inMinutes} 分钟后 · ${formatTime(next)}';
  return '${diff.inSeconds} 秒后';
}
