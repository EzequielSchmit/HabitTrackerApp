import 'package:flutter/material.dart';
import 'package:habit_tracker_app/widgets/days_row.dart';
import 'package:habit_tracker_app/widgets/separating_line.dart';
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
          SizedBox(height: 5,),
          Expanded(
            child: ListView(
              children: [
                UpcomingHabitsSection(),
                SeparatingLine(colors: colors),
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
