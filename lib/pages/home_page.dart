import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/date_time_extension.dart';
import 'package:habit_tracker_app/widgets/days_row.dart';
import 'package:habit_tracker_app/widgets/separating_line.dart';
import 'package:habit_tracker_app/widgets/daily_habits_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});

  final DailyHabitsController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        if (widget.controller.isLoading){
          return Center(child: CircularProgressIndicator(),);
        } 

        final colors = Theme.of(context).colorScheme;
        List<HabitEntry> upcomingList, completedList, failedList;
        final entriesFromSelectedDay = widget.controller.entriesFromSelectedDay;
        final today = DateTime.now().normalize();
        final selectedDayIsToday = today.isSameDay(widget.controller.selectedDate);
        if (selectedDayIsToday) {
          upcomingList = entriesFromSelectedDay.where((element) => (!element.completed && element.rule.type != CompletionType.atMost),).toList();
          completedList = entriesFromSelectedDay.where((element) => element.completed,).toList();
          failedList = entriesFromSelectedDay.where((element) => (!element.completed && element.rule.type == CompletionType.atMost),).toList();
        } else {
          upcomingList = [];
          completedList = entriesFromSelectedDay.where((element) => element.completed,).toList();
          failedList = entriesFromSelectedDay.where((element) => !element.completed,).toList();
        }

        return Container(
          width: double.infinity,
          color: colors.surfaceContainerLowest,
          child: Column(
            children: [
              DaysRow(controller: widget.controller),
              SizedBox(height: 5,),
              Expanded(
                child: ListView(
                  children: [
                    if (selectedDayIsToday)
                      DailyHabitsSection(
                        title: "Pendientes ${upcomingList.isNotEmpty ? "(${upcomingList.length})" : ""}",
                        entries: upcomingList,
                        messageWhenEmpty: "¡No hay hábitos pendientes para el día de hoy!",
                        controller: widget.controller,
                      ),
                    if (selectedDayIsToday)
                      SeparatingLine(colors: colors),
                    DailyHabitsSection(
                      title: "Completados ${completedList.isNotEmpty ? "(${completedList.length})" : ""}",
                      cardBackgroundColor: colors.secondary,
                      cardColor: colors.onSecondary,
                      entries: completedList,
                      messageWhenEmpty: "¡No hay hábitos completados aún!",
                      controller: widget.controller,
                    ),
                    SeparatingLine(colors: colors),
                    DailyHabitsSection(
                      title: "Fallados ${failedList.isNotEmpty ? "(${failedList.length})" : ""}",
                      cardBackgroundColor: colors.secondary,
                      cardColor: colors.onSecondary,
                      entries: failedList,
                      messageWhenEmpty: "No fallaste en ningun hábito ¡Seguí así!",
                      controller: widget.controller,
                    ),
                    
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
