import 'package:flutter/cupertino.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/pages/habits_page.dart';
import 'package:habit_tracker_app/pages/home_page.dart';
import 'package:habit_tracker_app/pages/settings_page.dart';
import 'package:habit_tracker_app/pages/statistics_page.dart';
import 'package:habit_tracker_app/widgets/greeting_title.dart';


enum AppTab {
  home(iconName: "home.svg", pageBuilder: _buildHome, title: GreetingTitle()),
  habits(iconName: "flags.svg", pageBuilder: _buildHabits, title: GreetingTitle()),
  statistics(iconName: "statistics.svg", pageBuilder: _buildStatistics, title: GreetingTitle()),
  settings(iconName: "settings.svg", pageBuilder: _buildSettings, title: GreetingTitle());
  
  final String iconName;
  final Widget Function(DailyHabitsController) pageBuilder;
  final Widget title;

  const AppTab({required this.iconName, required this.pageBuilder, required this.title});

}

Widget _buildHome(DailyHabitsController controller) {
  return HomePage(controller: controller);
}

Widget _buildHabits(DailyHabitsController controller) {
  return HabitsPage(controller: controller);
}

Widget _buildStatistics(DailyHabitsController controller) {
  return StatisticsPage(controller: controller);
}

Widget _buildSettings(DailyHabitsController controller) {
  return SettingsPage(controller: controller);
}


