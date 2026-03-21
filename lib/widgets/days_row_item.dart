import 'package:flutter/material.dart';
import 'package:habit_tracker_app/enums/month.dart';
import 'package:habit_tracker_app/enums/week_days.dart';
import 'package:habit_tracker_app/util/date_time_extension.dart';

class DaysRowItem extends StatelessWidget {
  const DaysRowItem({super.key, required this.date, required this.index, required this.isSelected, required this.onTap });
  
  final DateTime date;
  final bool isSelected;
  final Function(DateTime date, int index) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    bool  isItToday = this.isItToday(),
          isItAfterToday = DateTime.now().differenceInDaysWith(date) < 0;
    Color backgroundColor = isItToday? colors.primary : colors.secondary,
          foregroundColor = isItToday? colors.onPrimary : isItAfterToday? colors.onSecondary.withAlpha(100) : colors.onSecondary;
    String monthDim = Month.getMonthName(date.month).substring(0,3);
    return GestureDetector(
      onTap: (){
        onTap(date, index);
      },
      child: Container(
        margin: EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? Border.all(color: colors.onSecondary, width: 3) : null,
          color: backgroundColor,
        ),
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 0,
              children: [
                Text( WeekDay.getDayName(date.weekday).substring(0,3),
                  style: TextStyle(
                    fontSize: 14,
                    color: foregroundColor,
                    fontWeight: FontWeight.w300,
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
      ),
    );
  }

  bool isItToday(){
    DateTime now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }
}