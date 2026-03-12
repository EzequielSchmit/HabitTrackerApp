import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/days_row.dart';
import 'package:habit_tracker_app/widgets/upcoming_habits_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: colors.surfaceContainerLowest,
      child: Column(
        children: [
          DaysRow(),
          SizedBox(height: 20,),
          Expanded(
            child: ListView(
              children: [
                UpcomingHabitsSection(),
                Container(
                  height: 0.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [colors.onPrimary, colors.onSecondary.withAlpha(100), colors.onPrimary],
                      stops: [0.1, 0.5, 0.9],
                    ),
                  ),
                ),
                UpcomingHabitsSection(),
                UpcomingHabitsSection(),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
