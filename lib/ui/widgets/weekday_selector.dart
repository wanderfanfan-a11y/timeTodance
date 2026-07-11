import 'package:flutter/material.dart';

import '../utils/date_format_utils.dart';

/// 星期多选控件（1=周一 .. 7=周日）。
class WeekdaySelector extends StatelessWidget {
  final Set<int> selected;
  final ValueChanged<Set<int>> onChanged;

  const WeekdaySelector({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(7, (index) {
        final weekday = index + 1;
        final isSelected = selected.contains(weekday);
        return FilterChip(
          label: Text(weekdayShortLabels[index]),
          selected: isSelected,
          onSelected: (value) {
            final next = Set<int>.from(selected);
            if (value) {
              next.add(weekday);
            } else {
              next.remove(weekday);
            }
            onChanged(next);
          },
        );
      }),
    );
  }
}
