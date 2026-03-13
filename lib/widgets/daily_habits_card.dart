import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/styles.dart';

class DailyHabitsCard extends StatefulWidget {
  const DailyHabitsCard({super.key, required this.entry, required this.height, required this.verticalMargin, required this.onComplete});

  // final Habit habit;
  final HabitEntry entry;
  final double height, verticalMargin;
  final VoidCallback onComplete;
  
  @override
  State<DailyHabitsCard> createState() => _DailyHabitsCardState();
}

class _DailyHabitsCardState extends State<DailyHabitsCard> {
  
  bool _isAnimating = false;

  Future<void> _handleComplete() async {
    setState(() {
      _isAnimating = true;
    });
    String habitName = widget.entry.habit.name;
    await Future.delayed(Duration(milliseconds: 350));
    widget.onComplete();
  }
  
  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double cardPadding = 15;
    final double iconHeight = widget.height - 2*cardPadding;
    final bool completed = widget.entry.completed;
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: completed ? colors.secondary : widget.entry.habit.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: iconHeight,
            width: iconHeight,
            decoration: BoxDecoration(
              color: colors.onPrimary.withAlpha(100),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.entry.habit.name,
                  style: Styles.cardHabitName.copyWith(
                    color: completed? colors.onSecondary : colors.onPrimary),
                  ),
                Text(
                  widget.entry.habit.getFrequencyDescription(),
                  style: Styles.cardHabitFrequencyDescription.copyWith(
                    color: completed? colors.onSecondary : colors.onPrimary),
                ),
              ],
            )
          ),
          CompleteButton(iconHeight: iconHeight, colors: colors, onChanged: _handleComplete,),
        ]
      ),
    );
  }
}

class CompleteButton extends StatelessWidget {
  const CompleteButton({
    super.key,
    required this.iconHeight,
    required this.colors,
    required this.onChanged,
  });

  final double iconHeight;
  final ColorScheme colors;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(),
      child: Container(
        height: iconHeight,
        width: iconHeight,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: colors.onPrimary.withAlpha(100),
          borderRadius: BorderRadius.circular(iconHeight),
        ),
        child: Container(
          height: iconHeight,
          width: iconHeight,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: colors.onPrimary, width: 1.5),
            borderRadius: BorderRadius.circular(iconHeight),
          ),
          
        ),
      ),
    );
  }
}