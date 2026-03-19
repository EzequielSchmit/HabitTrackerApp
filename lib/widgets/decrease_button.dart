import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/styles.dart';

class DecreaseButton extends StatelessWidget {
  const DecreaseButton({super.key, required this.iconHeight, required this.onProgressChange, required this.entry, required this.controller});

  final DailyHabitsController controller;
  final HabitEntry entry;
  final double iconHeight;
  final Function(bool) onProgressChange;

  void _handleTap() async {
    bool changed = await controller.decrementProgress(entry);
    onProgressChange(changed);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        width: iconHeight,
        height: iconHeight,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(iconHeight),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.onSecondary.withAlpha(22),
            
            borderRadius: BorderRadius.circular(iconHeight),
          ),
          child: Text("-", style: Styles.sectionTitle.copyWith(color: colors.onPrimary.withAlpha(199)),)
        ),
      )
    );
  }
}