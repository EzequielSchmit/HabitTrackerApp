import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key, required this.controller});

  final DailyHabitsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("pagina de habitos"),
    );
  }
}