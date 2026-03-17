import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
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

  Future<int?> _changeProgressWithValidation(BuildContext context, CompletionRule rule) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();

    String? result = await showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nuevo valor de progreso",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Campo obligatorio";
                int? n = int.tryParse(value);
                if (n == null) return "Debe ser un número";
                if (rule.isLimitedByTarget && n > rule.completionTarget) return "El valor debe ser menor a ${rule.completionTarget}";
                if (n < 0) return "El valor debe ser mayor a 0";

                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, controller.text);
                }
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      }
    );

    return int.tryParse(result ?? "");
  }

  Future<void> _handleProgressChangeWithValidation(BuildContext context) async {
    int? result = await _changeProgressWithValidation(context, widget.entry.rule);
    if (result != null) {
      bool wasCompleted = widget.entry.completed;
      widget.entry.progress = result;
      bool isCompleted = widget.entry.completed;
      if (wasCompleted && isCompleted){
        _rebuild();
      } else {
        _handleCompleteAnimation();
      }
    }
  }

  void _rebuild() {
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
          // padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: completed && !_isAnimating ? colors.secondary : widget.entry.habit.backgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(cardPadding),
                child: Row(
                  children: [
                    getHabitIcon(iconHeight, colors),
                    SizedBox(width: 15),
                    getHabitInfoText(completed, colors),
                    if (!widget.entry.completed && !widget.entry.rule.trivial && widget.entry.progress > 0)
                      DecreaseButton(iconHeight: iconHeight, onDecrease: _handleDecrease), 
                    CompleteButton(
                      iconHeight: iconHeight,
                      colors: colors,
                      isAnimating: _isAnimating,
                      entry: widget.entry,
                      onChanged: _handleComplete,
                      onChangeAnimated: _handleCompleteAnimation,
                      onLongPress: () async {_handleProgressChangeWithValidation(context);},
                    ),
                  ]
                ),
              ),
              if (/*!widget.entry.completed &&*/ !widget.entry.rule.trivial && widget.entry.progress > 0)
                getProgressField(context, cardPadding, iconHeight, colors),
            ]
          ),
        ),
      ),
    );
  }

  Positioned getProgressField(BuildContext context, double cardPadding, double iconHeight, ColorScheme colors) {
    return Positioned(
      bottom: 1,
      right: cardPadding/*+iconHeight*/,
      child: GestureDetector(
        // onTap: () async {_handleProgressChangeWithValidation(context, widget.entry.rule.completionTarget);},
        child: Container(
          // color: Colors.red,
          width: iconHeight,
          alignment: Alignment.center,
          child: Text(
            "${widget.entry.progress}/${widget.entry.rule.completionTarget}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.entry.completed? colors.onSecondary.withAlpha(180) : colors.secondary,
              fontSize: 10
            ),
          ),
        ),
      )
    );
  }

  Container getHabitIcon(double iconHeight, ColorScheme colors) {
    return Container(
                    height: iconHeight,
                    width: iconHeight,
                    decoration: BoxDecoration(
                      color: colors.onPrimary.withAlpha(100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
  }

  Expanded getHabitInfoText(bool completed, ColorScheme colors) {
    return Expanded(
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
                  );
  }
}

enum ButtonIcon {
  plus(iconName: "plus.svg"),
  completed(iconName: "complete-black.svg");
  final String iconName;
  const ButtonIcon({required this.iconName});
}