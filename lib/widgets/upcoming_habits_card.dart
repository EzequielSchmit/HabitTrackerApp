import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit.dart';

class UpcomingHabitsCard extends StatelessWidget {
  const UpcomingHabitsCard({super.key, required this.habit, required this.height, required this.verticalMargin});

  final Habit habit;
  final double height, verticalMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: verticalMargin),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: habit.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(habit.name)
        ]
      ),
    );
  }
}