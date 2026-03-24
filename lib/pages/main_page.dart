import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/enums/app_tab.dart';
import 'package:habit_tracker_app/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.controller});

  final DailyHabitsController controller;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  AppTab selectedTab = AppTab.home;

  void _handleSelectTab(AppTab tab){
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.secondary,
      appBar: AppBar(
        backgroundColor: colors.secondary,
        surfaceTintColor: colors.secondary,
        toolbarHeight: 90,
        title: selectedTab.title,
      ),

      body: selectedTab.pageBuilder(widget.controller),

      bottomNavigationBar: BottomNavBar(
        onSelectTab: _handleSelectTab,
        selectedTab: selectedTab,
        controller: widget.controller,
      ),
    );
  }
}