import 'package:flutter/material.dart';

import '../../domain/models/timer_task.dart';

String timerTypeLabel(TimerType type) {
  switch (type) {
    case TimerType.once:
      return '指定时刻';
    case TimerType.countdown:
      return '倒计时';
    case TimerType.interval:
      return '固定间隔';
    case TimerType.daily:
      return '每日固定时刻';
    case TimerType.weekly:
      return '按星期';
  }
}

String timerTypeDescription(TimerType type) {
  switch (type) {
    case TimerType.once:
      return '指定某一天的某个时刻，只提醒一次';
    case TimerType.countdown:
      return '从现在开始倒数一段时间后提醒一次';
    case TimerType.interval:
      return '每隔固定时长循环提醒（可限制生效星期/时段）';
    case TimerType.daily:
      return '每天在一个或多个固定时刻提醒';
    case TimerType.weekly:
      return '在选定的星期几、固定时刻提醒';
  }
}

IconData timerTypeIcon(TimerType type) {
  switch (type) {
    case TimerType.once:
      return Icons.event_outlined;
    case TimerType.countdown:
      return Icons.hourglass_bottom_outlined;
    case TimerType.interval:
      return Icons.repeat_outlined;
    case TimerType.daily:
      return Icons.schedule_outlined;
    case TimerType.weekly:
      return Icons.calendar_view_week_outlined;
  }
}

String endConditionLabel(EndConditionType type) {
  switch (type) {
    case EndConditionType.never:
      return '永不结束';
    case EndConditionType.byDate:
      return '到某日期结束';
    case EndConditionType.byCount:
      return '触发 N 次后停止';
  }
}
