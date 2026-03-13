import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/util/styles.dart';

class UpcomingHabitsCard extends StatelessWidget {
  const UpcomingHabitsCard({super.key, required this.habit, required this.height, required this.verticalMargin});

  final Habit habit;
  final double height, verticalMargin;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double cardPadding = 15;
    final double iconHeight = height - 2*cardPadding;
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: habit.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: iconHeight,
            width: iconHeight,
            decoration: BoxDecoration(
              color: colors.onPrimary.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.name,
                  style: Styles.cardHabitName.copyWith(
                    color: colors.onPrimary),
                  ),
                Text(
                  habit.getFrequencyDescription(),
                  style: Styles.cardHabitFrequencyDescription.copyWith(
                    color: colors.onPrimary),
                ),
              ],
            )
          ),
          Container(
            height: iconHeight,
            width: iconHeight,
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: colors.onPrimary.withAlpha(100),
              borderRadius: BorderRadius.circular(iconHeight),
            ),
            child: Container(
              height: iconHeight,
              width: iconHeight,
              decoration: BoxDecoration(
                border: BoxBorder.all(color: colors.onPrimary, width: 1.5),
                borderRadius: BorderRadius.circular(iconHeight),
              ),
              
            ),
          ),
        ]
      ),
    );
  }
}