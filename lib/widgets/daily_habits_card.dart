import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/styles.dart';
import 'package:habit_tracker_app/widgets/complete_button.dart';
import 'package:habit_tracker_app/widgets/decrease_button.dart';

class DailyHabitsCard extends StatefulWidget {
  const DailyHabitsCard({super.key, required this.entry, required this.height, required this.verticalMargin,
                        required this.onEntryChanged, required this.onAction});

  // final Habit habit;
  final HabitEntry entry;
  final double height, verticalMargin;
  final VoidCallback onEntryChanged;
  final Function(HabitEntry entry) onAction;
  
  @override
  State<DailyHabitsCard> createState() => _DailyHabitsCardState();
}

class _DailyHabitsCardState extends State<DailyHabitsCard> {
  
  bool _isAnimating = false;

  void _handleComplete() {
    widget.onAction(widget.entry);
  }
  
  Future<void> _handleCompleteAnimation() async {
    if (widget.entry.completed){
      setState(() {
        _isAnimating = true;
      });
      await Future.delayed(Duration(milliseconds: 350));
      setState(() {
        _isAnimating = false;
      });
    }
      widget.onEntryChanged();
  }

  void _handleDecrease(){
    widget.entry.progress--;  
    setState(() => ());
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double cardPadding = 15;
    final double iconHeight = widget.height - 2*cardPadding;
    final bool completed = widget.entry.completed;
    
    return AnimatedOpacity(
      duration: Duration(milliseconds: 350),
      opacity: _isAnimating ? 0 : 1,
      child: AnimatedScale(
        duration: Duration(milliseconds: 350),
        scale: _isAnimating ? 0.95 : 1,
        child: Container(
          height: widget.height,
          margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: completed && !_isAnimating ? colors.secondary : widget.entry.habit.backgroundColor,
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
              if (!widget.entry.completed && !widget.entry.rule.trivial && widget.entry.progress > 0)
                DecreaseButton(iconHeight: iconHeight, onDecrease: _handleDecrease),
                // Opacity( //porque por algun motivo la condicion de "widget.entry.progress > 0 del if parece que esta devolviendo true (?), ¿quizas por el orden de renderizado y creacion de objetos?"
                //   opacity: widget.entry.progress > 0 ? 1 : 0,
                //   child: DecreaseButton(iconHeight: iconHeight, onDecrease: _handleDecrease),
                // ),  
              CompleteButton(iconHeight: iconHeight, colors: colors, isAnimating: _isAnimating, onChanged: _handleComplete,
                            onChangeAnimated: _handleCompleteAnimation, entry: widget.entry),
            ]
          ),
        ),
      ),
    );
  }
}

enum ButtonIcon {
  plus(iconName: "plus.svg"),
  completed(iconName: "complete-black.svg");
  final String iconName;
  const ButtonIcon({required this.iconName});
}