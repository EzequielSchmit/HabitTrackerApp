import 'package:flutter/material.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/styles.dart';
import 'package:habit_tracker_app/widgets/complete_button.dart';
import 'package:habit_tracker_app/widgets/decrease_button.dart';

class DailyHabitsCard extends StatefulWidget {
  const DailyHabitsCard({super.key,
    required this.entry,
    required this.cardBackgroundColor,
    required this.cardColor,
    required this.height,
    required this.verticalMargin,
    required this.controller
  });

  final DailyHabitsController controller;
  final HabitEntry entry;
  final Color cardBackgroundColor;
  final Color cardColor;
  final double height, verticalMargin;
  
  @override
  State<DailyHabitsCard> createState() => _DailyHabitsCardState();
}

class _DailyHabitsCardState extends State<DailyHabitsCard> {
  
  bool _isAnimatingFadeOut = false;
  
  Future<void> _handleIncreaseTap() async {
    bool willComplete = widget.controller.completedStateWillChange(widget.entry, widget.entry.progress + 1);
    if (willComplete){
      await _animateProgressChange(true);
    }

    await widget.controller.incrementProgress(widget.entry);
    
    if (!mounted) return;

    _animateProgressChange(false);
  }

  Future<void> _animateProgressChange(bool completedStateChanged) async {
    if (completedStateChanged){
      //Animacion fade out
      setState(() {
        _isAnimatingFadeOut = true;
      });
      await Future.delayed(Duration(milliseconds: 350));
      if (!mounted) return;
    } else {
      //Si no hubo cambio del estado completado solo actualiza este widget (ejemplo, los textos (por ejemplo, progreso pasa de "2/4" a "3/4"))
      _refreshUI();
      
    }
  }

  Future<int?> _showProgressSetterDialog(BuildContext context, CompletionRule rule) async {
    final _formKey = GlobalKey<FormState>();
    TextEditingController textController = TextEditingController();

    String? result = await showDialog(context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Nuevo valor de progreso",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Campo obligatorio";
                int? n = int.tryParse(value);
                if (n == null) return "Debe ser un número";
                //if (rule.type == CompletionType.exactly && n > rule.completionTarget) return "El valor debe ser menor a ${rule.completionTarget}";
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
                  Navigator.pop(context, textController.text);
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

  Future<void> _handleProgressSetter(BuildContext context) async {
    int? result = await _showProgressSetterDialog(context, widget.entry.rule);
    if (result != null) {
      bool changed = await widget.controller.setProgress(widget.entry, result);
      _animateProgressChange(changed);
    }
  }

  void _refreshUI() {
    setState(() => ());
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double cardPadding = 15;
    final double iconHeight = widget.height - 2*cardPadding;
    
    return AnimatedOpacity(
      duration: Duration(milliseconds: 350),
      opacity: _isAnimatingFadeOut ? 0 : 1,
      child: AnimatedScale(
        duration: Duration(milliseconds: 350),
        scale: _isAnimatingFadeOut ? 0.95 : 1,
        child: Container(
          height: widget.height,
          margin: EdgeInsets.symmetric(vertical: widget.verticalMargin),
          // padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: widget.cardBackgroundColor, 
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(cardPadding),
                child: Row(
                  children: [
                    getHabitIcon(iconHeight, colors),
                    SizedBox(width: 10),
                    getHabitInfoText(colors),
                    Opacity(
                      opacity: widget.entry.progress > 0 ? 1 : 0,
                      child: DecreaseButton(
                        iconHeight: iconHeight,
                        onProgressChange: _animateProgressChange,
                        entry: widget.entry,  
                        controller: widget.controller,
                      )
                    ), 
                    CompleteButton(
                      iconHeight: iconHeight,
                      backgroundColor: widget.cardColor,
                      color: widget.cardBackgroundColor,
                      isAnimating: _isAnimatingFadeOut,
                      entry: widget.entry,
                      onTap: () async {_handleIncreaseTap();},
                      onLongPress: () async {_handleProgressSetter(context);},
                      controller: widget.controller,
                    ),
                  ]
                ),
              ),
              getProgressText(context, cardPadding, iconHeight, colors),
            ]
          ),
        ),
      ),
    );
  }

  Positioned getProgressText(BuildContext context, double cardPadding, double iconHeight, ColorScheme colors) {
    return Positioned(
      bottom: 1,
      right: cardPadding,
      child: Container(
        width: iconHeight,
        alignment: Alignment.center,
        child: Text(
          "${widget.entry.progress}/${widget.entry.rule.completionTarget}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.cardColor,
            fontSize: 10
          ),
        ),
      ),
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

  Expanded getHabitInfoText(ColorScheme colors) {
    
    bool isPositiveHabit = widget.entry.rule.type != CompletionType.atMost;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              "${isPositiveHabit? "+" : "-"} ${widget.entry.habit.name}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              // softWrap: true,
              style: Styles.cardHabitName.copyWith(
                color: widget.cardColor,
              ),
            ),
          ),
          Padding(
            // padding: EdgeInsets.only(left: iconSize + 2*iconPadding + iconMargin),
            padding: EdgeInsets.only(left: 0),
            
            child: Text(
              widget.entry.getFrequencyDescription(),
              style: Styles.cardHabitFrequencyDescription.copyWith(
                color: widget.cardColor,
              )
            ),
          ),
        ],
      )
    );
  }
}
