import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/paths.dart';
import 'package:habit_tracker_app/widgets/daily_habits_card.dart';

class CompleteButton extends StatefulWidget {
  const CompleteButton({
    super.key,
    required this.iconHeight,
    required this.colors,
    required this.onChanged,
    required this.isAnimating,
    required this.entry,
  });

  final double iconHeight;
  final ColorScheme colors;
  final Function() onChanged;
  final bool isAnimating;
  final HabitEntry entry;

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {

  bool _isAnimating = false;
  bool _isPressed = false;
  late ButtonIcon currentIcon;
  late int progressPercentage;

  Future<void> _handleTap() async {


    setState(() {
      _isAnimating = true;
      HabitEntry entry = widget.entry;
      progressPercentage = entry.getProgressPercentage(entry.progress+1);
      if (widget.entry.isAboutToBeCompleted()){
        currentIcon = ButtonIcon.completed;
      }
    });
    await Future.delayed(Duration(milliseconds: 200));
    
    
    setState(() {
      _isAnimating = false;
    });

    widget.onChanged();
  }

  Future<void> _handleTapDown() async {
    if (!widget.entry.isAboutToBeCompleted()){
      setState(() {
        _isPressed= true;
        // _isAnimating = true;
      });
      await Future.delayed(Duration(milliseconds: 200));
      setState(() {
        _isPressed= false;
        // _isAnimating = false;
      });
    }
  }

  @override
  void initState(){
    super.initState();
    progressPercentage = widget.entry.getProgressPercentage(widget.entry.progress);
    currentIcon = widget.entry.completed || widget.entry.rule.trivial ? ButtonIcon.completed : ButtonIcon.plus;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.isAnimating ? null : (_) => _handleTapDown(),
      onTap: widget.isAnimating ? null : () => _handleTap(),
      child: Container(
        height: widget.iconHeight,
        width: widget.iconHeight,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: widget.colors.onPrimary.withAlpha(100),
          borderRadius: BorderRadius.circular(widget.iconHeight),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!widget.entry.rule.trivial)// && !widget.entry.completed)
              SizedBox(
                height: widget.iconHeight,
                width: widget.iconHeight,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey(widget.entry.id),
                  tween: Tween(
                    end: progressPercentage / 100,
                  ),
                  duration: Duration(milliseconds: 200),
                  builder: (context, value, child){
                    return CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5,
                      color: colors.onSecondary.withAlpha(160),
                    );
                  },
                ),
              ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: getIcon(colors),
            ),

          ]
        ),
      ),
    );
  }

  Container getIcon(ColorScheme colors) {
    Color backgroundColor, color;
    if (_isPressed || (currentIcon == ButtonIcon.completed && widget.entry.completed)){
      backgroundColor = colors.onSecondary;
      color = colors.onPrimary;
    } else {
      backgroundColor = colors.onPrimary;
      color = colors.onSecondary.withAlpha(80);
    }
    // Color backgroundColor = (_isPressed || currentIcon == ButtonIcon.completed) ? colors.onSecondary : colors.onPrimary,
    //       color = (_isPressed || currentIcon == ButtonIcon.completed) ? colors.onPrimary : colors.onSecondary.withAlpha(80);

    return Container(
      height: widget.iconHeight,
      width: widget.iconHeight,
      decoration: BoxDecoration(
        // border: BoxBorder.all(color: widget.colors.onPrimary, width: 1.5),
        borderRadius: BorderRadius.circular(widget.iconHeight),
        color: currentIcon == ButtonIcon.plus ? backgroundColor : color,
      ),
      child: getSvgIcon(backgroundColor: backgroundColor, color: color),
    );
  }

  SvgPicture getSvgIcon({required Color backgroundColor, required Color color}){
    String iconName = currentIcon.iconName;
    if (currentIcon == ButtonIcon.plus) {
      return SvgPicture.asset("${Paths.iconFolderPath}$iconName",
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset("${Paths.iconFolderPath}$iconName",
        colorFilter: ColorFilter.mode(backgroundColor, BlendMode.srcIn),
      );
    }
  }


}
