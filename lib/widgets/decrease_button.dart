import 'package:flutter/material.dart';
import 'package:habit_tracker_app/util/styles.dart';

class DecreaseButton extends StatelessWidget {
  const DecreaseButton({super.key, required this.iconHeight, required this.onDecrease});

  final double iconHeight;
  final VoidCallback onDecrease;

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => onDecrease(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0),
        width: iconHeight,
        height: iconHeight,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(iconHeight),
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.onSecondary.withAlpha(22),
            
            borderRadius: BorderRadius.circular(iconHeight),
          ),
          child: Text("-", style: Styles.sectionTitle.copyWith(color: colors.onPrimary.withAlpha(199)),)
        ),
      )
    );
  }
}