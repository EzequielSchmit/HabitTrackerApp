import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_tracker_app/util/paths.dart';
import 'package:habit_tracker_app/enums/app_tab.dart';
import 'package:habit_tracker_app/widgets/nav_button.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.selectedTab, required this.selectTab});

  final AppTab selectedTab;
  final Function(AppTab tab) selectTab;
  

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final double iconWidth = 50;
    return BottomAppBar(
      padding: EdgeInsets.all(10),
      height: 110,
      color: colors.surfaceContainerLowest,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: colors.inverseSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Expanded(
            //   // color: Colors.red,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //     ],
            //   ),
            // ),
            for (int i = 0; i < 2; i++)
              getNavButtonFromTab(AppTab.values[i], iconWidth),
            Container(
              width: iconWidth+16,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.primary.withAlpha(150),
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.primary,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "${Paths.iconFolderPath}plus.svg",
                  colorFilter: ColorFilter.mode(colors.surfaceContainerLowest, BlendMode.srcIn),
                ),

              ),
            ),
            // Expanded(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //     ],
            //   ),
            // ),
            for (int i = 2; i < 4; i++)
              getNavButtonFromTab(AppTab.values[i], iconWidth),
            // for (AppTab tab in AppTab.values)
            //   getNavButtonFromTab(tab, iconWidth),
          ],
        ),
      ),
    );
  }

  NavButton getNavButtonFromTab(AppTab tab, double iconWidth) {
    return NavButton(
              iconPath: tab.iconName,
              width: iconWidth,
              isSelected: selectedTab == tab,
              select: () => selectTab(tab),
            );
  }
}