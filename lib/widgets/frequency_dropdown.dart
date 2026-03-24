import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit_frequency.dart';
import 'package:habit_tracker_app/util/styles.dart';

class FrequencyDropdown extends StatelessWidget {
  FrequencyDropdown({super.key, required this.frequency, required this.onChanged});

  final FrequencyType frequency;
  final void Function(FrequencyType) onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DropdownButton(
      value: frequency,
      isExpanded: true,
      items: FrequencyType.values.map( (e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e.name, style: Styles.creationConfigItem.copyWith(color: colors.onSecondary.withAlpha(200)),),
        );
      },).toList(),
      onChanged: (v) => onChanged(v!));
  }
}