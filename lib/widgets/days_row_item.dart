import 'package:flutter/material.dart';
import 'package:habit_tracker_app/enums/month.dart';
import 'package:habit_tracker_app/enums/week_days.dart';

class DaysRowItem extends StatelessWidget {
  const DaysRowItem({super.key, required this.date, });
  
  final DateTime date;
  // final double width;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colores = Theme.of(context).colorScheme;
    Color backgroundColor = isItToday()? colores.primary : colores.secondary,
          foregroundColor = isItToday()? colores.onPrimary : colores.onSecondary;
    String monthDim = Month.getMonthName(date.month).substring(0,3);
    return Container(
      // width: width,
      margin: EdgeInsets.symmetric(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text( WeekDay.getDayName(date.weekday).substring(0,3),
                style: TextStyle(
                  fontSize: 16,
                  color: foregroundColor,
                  fontWeight: FontWeight.w300
                ),
              ),
              Text("${date.day}",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
          if (date.day == 1)
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                child: Text(
                  date.month == 1 ? "$monthDim ${date.year}" : monthDim,
                  style: TextStyle(
                    fontSize: 12,
                    color: foregroundColor.withAlpha(100)
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bool isItToday(){
    DateTime now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }
}