import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
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

  List<HabitEntry> entriesFromSelectedDay = [];
  bool _isLoading = true;

  @override
  void initState(){
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    DateTime now, today;
    now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);

    final entries = await widget.controller.getEntriesByDate(today);
    // await Future.delayed(Duration(milliseconds: 100));

    if (!mounted) return;
    setState(() {
      entriesFromSelectedDay = entries;
      _isLoading = false;
    });

  }

  void _refreshUI() {
    setState(()=>());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    List<HabitEntry> upcomingList, completedList, failedList;
    upcomingList = entriesFromSelectedDay.where((element) => (!element.completed && element.rule.type != CompletionType.atMost),).toList();
    completedList = entriesFromSelectedDay.where((element) => element.completed,).toList();
    failedList = entriesFromSelectedDay.where((element) => (!element.completed && element.rule.type == CompletionType.atMost),).toList();
    if (_isLoading){
      return Container(
        color: colors.surfaceContainerLowest,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    } else {
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
                    title: "Pendientes ${upcomingList.isNotEmpty ? "(${upcomingList.length})" : ""}",
                    entries: upcomingList,
                    onEntryChanged: _refreshUI,
                    messageWhenEmpty: "¡No hay hábitos pendientes para el día de hoy!",
                    controller: widget.controller,
                  ),
                  SeparatingLine(colors: colors),
                  DailyHabitsSection(
                    title: "Completados ${completedList.isNotEmpty ? "(${completedList.length})" : ""}",
                    cardBackgroundColor: colors.secondary,
                    cardColor: colors.onSecondary,
                    entries: completedList,
                    onEntryChanged: _refreshUI,
                    messageWhenEmpty: "¡No hay hábitos completados aún!",
                    controller: widget.controller,
                  ),
                  SeparatingLine(colors: colors),
                  DailyHabitsSection(
                    title: "Fallados ${failedList.isNotEmpty ? "(${failedList.length})" : ""}",
                    cardBackgroundColor: colors.secondary,
                    cardColor: colors.onSecondary,
                    entries: failedList,
                    onEntryChanged: _refreshUI,
                    messageWhenEmpty: "No fallaste en ningun hábito ¡Seguí así!",
                    controller: widget.controller,
                  ),
                  
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
