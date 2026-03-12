import 'package:flutter/cupertino.dart';
import 'package:habit_tracker_app/pages/habits_page.dart';
import 'package:habit_tracker_app/pages/home_page.dart';
import 'package:habit_tracker_app/pages/settings_page.dart';
import 'package:habit_tracker_app/pages/statistics_page.dart';
import 'package:habit_tracker_app/widgets/greeting_title.dart';


enum AppTab {
  home(iconName: "home.svg", page: HomePage(), title: GreetingTitle()),
  habits(iconName: "flags.svg", page: HabitsPage(), title: GreetingTitle()),
  statistics(iconName: "statistics.svg", page: StatisticsPage(), title: GreetingTitle()),
  settings(iconName: "settings.svg", page: SettingsPage(), title: GreetingTitle());

  final String iconName;
  final Widget page;
  final Widget title;

  const AppTab({required this.iconName, required this.page, required this.title});
}
