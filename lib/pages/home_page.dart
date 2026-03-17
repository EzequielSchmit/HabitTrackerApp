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
    DateTime now, today;
    now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);
    /*
    for (int i = 1; i < 11; i++){
      Color randomColor = colors[random.nextInt(colors.length)];
      Habit habit = Habit(name: "Habito $i", backgroundColor: randomColor, id: Habit.getNewId());
      CompletionRule rule = CompletionRule(
        id: 1,
        completionTarget: 3,// random.nextInt(3)+1,
        startDate: today,
      );
      habit.addRule(rule);
      habits.add(habit);
    }

    for (Habit h in habits){
      entriesFromSelectedDay.add(HabitEntry(habit: h, date: today, progress: 0));
    }

    */

    //

    Habit habit = Habit(name: "Tomar vasos de agua", backgroundColor: MyColors.colors[1], id: 1);

    CompletionRule r1 = CompletionRule(id: 1, completionTarget: 3, startDate: today.add(Duration(days: -10)));

    habit.addRule(r1);

    entriesFromSelectedDay.add(HabitEntry(habit: habit, date: today, progress: 0));

  }

  void _rebuild() {
    setState(()=>());
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
                  onEntryChanged: _rebuild,
                  onAction: (entry){entry.progress++;},
                  messageWhenEmpty: "¡No hay hábitos pendientes para los próximos días!",
                ),
                SeparatingLine(colors: colors),
                DailyHabitsSection(
                  title: "Completado",
                  entries: entriesFromSelectedDay.where((element) => element.completed,).toList(),
                  onEntryChanged: _rebuild,
                  onAction: (entry){entry.progress=0;},
                  messageWhenEmpty: "¡No hay hábitos completados aún!",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
