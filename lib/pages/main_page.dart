import 'package:flutter/material.dart';
import 'package:habit_tracker_app/pages/home_page.dart';
import 'package:habit_tracker_app/pages/main_page.dart';
import 'package:habit_tracker_app/enums/app_tab.dart';
import 'package:habit_tracker_app/widgets/bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  AppTab selectedTab = AppTab.home;

  void selectTab(AppTab tab){
    setState(() {
      selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: colors.surfaceContainerLowest,
        toolbarHeight: 120,
        title: selectedTab.title,
      ),

      body: selectedTab.page,

      bottomNavigationBar: BottomNavBar(
        selectTab: selectTab,
        selectedTab: selectedTab,
      ),
    );
  }
}