import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/data/repositories/fake_habit_entry_repository.dart';
import 'package:habit_tracker_app/data/repositories/fake_habit_repository.dart';
import 'package:habit_tracker_app/data/repositories/habit_entry_repository.dart';
import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/pages/main_page.dart';

void main() {

  HabitRepository habitRepository = FakeHabitRepository();
  HabitEntryRepository entryRepository = FakeHabitEntryRepository(habitRepository: habitRepository);

  DailyHabitsController controller = DailyHabitsController(habitRepository: habitRepository, entryRepository: entryRepository);

  runApp(MyApp(controller: controller,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.controller});

  final DailyHabitsController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker App',
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 65, 65),
          primary: const Color(0xFFFF6B81),
          onPrimary: const Color(0xFFFFFFFF),
          secondary: const Color(0xFFf2f2f2),
          onSecondary: const Color.fromARGB(255, 51, 51, 76),
          surfaceContainerLowest: const Color(0xFFFFFFFF),
          onSurface: const Color.fromARGB(255, 51, 51, 76),
          inverseSurface: const Color.fromARGB(255, 51, 51, 76),
          tertiary: const Color.fromARGB(255, 51, 51, 76),
          onTertiary: const Color(0xFFFFFFFF),
          brightness: Brightness.light,
        ),
        fontFamily: "GoogleSans",
      ),
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: const Color.fromARGB(255, 255, 65, 65), //const Color.fromARGB(255, 255, 0, 0),
          brightness: Brightness.dark
        ),
        fontFamily: "GoogleSans"
      ),
      themeMode: ThemeMode.light,
      home: MainPage(controller: controller,),
    );
  }
}