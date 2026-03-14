import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/my_colors.dart';
import 'package:habit_tracker_app/widgets/days_row.dart';
import 'package:habit_tracker_app/widgets/separating_line.dart';
import 'package:habit_tracker_app/widgets/daily_habits_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<HabitEntry> entriesFromSelectedDay = [];

  @override
  void initState(){
    super.initState();
      
    List<Habit> habits = [];

    List<Color> colors = MyColors.colors;
    Random random = Random();
    for (int i = 1; i < 11; i++){
      Color randomColor = colors[random.nextInt(colors.length)];
      habits.add(Habit(name: "Habito $i", backgroundColor: randomColor, id: Habit.getNewId()));
    }

    DateTime now, today;
    now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);
    for (Habit h in habits){
      CompletionRule rule = CompletionRule(
        id: 1,
        habit: h,
        completionTarget: 1,
        startDate: today,
        endDate: today
      );
      entriesFromSelectedDay.add(HabitEntry(habit: h, date: today, rule: rule, progress: 0));
    }
  }

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
                DailyHabitsSection(
                  title: "Próximos hábitos",
                  entries: entriesFromSelectedDay.where((element) => !element.completed,).toList(),
                  onComplete: (entry) {
                    setState(() {
                      entry.incrementProgress();
                    });
                  },
                ),
                SeparatingLine(colors: colors),
                DailyHabitsSection(
                  title: "Completado",
                  entries: entriesFromSelectedDay.where((element) => element.completed,).toList(),
                  onComplete: (entry) {
                    setState(() {
                      entry.decrementProgress();
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
