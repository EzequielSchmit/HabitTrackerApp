import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker_app/util/paths.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.iconPath, required this.width, required this.isSelected, required this.select});

  final String iconPath;
  final double width;
  final bool isSelected;
  final Function select;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => select(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: width,
        padding: EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: isSelected? colors.surfaceContainerLowest : colors.inverseSurface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SvgPicture.asset(
          "${Paths.iconFolderPath}${iconPath}",
          colorFilter: ColorFilter.mode(isSelected? colors.inverseSurface : colors.surfaceContainerLowest, BlendMode.srcIn),
        ),
      ),
    );
  }
}