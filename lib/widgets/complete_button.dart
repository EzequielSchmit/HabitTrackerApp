import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker_app/controllers/daily_habits_controller.dart';
import 'package:habit_tracker_app/enums/my_icon.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/color_extension.dart';
import 'package:habit_tracker_app/util/paths.dart';

class CompleteButton extends StatefulWidget {
  const CompleteButton({
    super.key,
    required this.iconHeight,
    required this.backgroundColor,
    required this.color,
    required this.onTap,
    required this.onLongPress,
    required this.isAnimating,
    required this.entry,
    required this.controller
  });

  final DailyHabitsController controller;
  final double iconHeight;
  final Color backgroundColor;
  final Color color;
  final Function() onTap;
  final Function() onLongPress;

  final bool isAnimating;
  final HabitEntry entry;

  @override
  State<CompleteButton> createState() => _CompleteButtonState();
}

class _CompleteButtonState extends State<CompleteButton> {

  bool _isPressed = false;
  late int progressPercentage;
  final int durationOfPressEffectInMilis = 200;


  Future<void> _handleTapDown() async {
    setState(() {
      _isPressed= true;
    });
    await Future.delayed(Duration(milliseconds: durationOfPressEffectInMilis));
    if (!mounted) return;
    setState(() {
      _isPressed= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: widget.isAnimating ? null : (_) => _handleTapDown(),
      onTap: widget.isAnimating ? null : widget.onTap,
      onLongPress: widget.onLongPress,
      child: Container(
        height: widget.iconHeight,
        width: widget.iconHeight,
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
          color: widget.backgroundColor.withAlpha(100),
          borderRadius: BorderRadius.circular(widget.iconHeight),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.iconHeight,
              width: widget.iconHeight,
              child: TweenAnimationBuilder<double>(
                key: ValueKey(widget.entry.id),
                tween: Tween(
                  end: widget.entry.getProgressPercentage() / 100,
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
              child: _getIcon(colors),
            ),

          ]
        ),
      ),
    );
  }

  Container _getIcon(ColorScheme colors) {
    Color backgroundColor, foregroundColor;

    backgroundColor = widget.backgroundColor;
    foregroundColor = widget.color.withAlpha(200);

    if (_isPressed){
      backgroundColor = backgroundColor.toGrayScale();
      backgroundColor = backgroundColor.isADarkColor? backgroundColor.withLuminance(0.95) : backgroundColor.withLuminance(0.4);
    }

    return Container(
      height: widget.iconHeight,
      width: widget.iconHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.iconHeight),
        color: currentIcon == MyIcon.plus ? backgroundColor : foregroundColor,
      ),
      child: _getSvgIcon(backgroundColor: backgroundColor, color: foregroundColor),
    );
  }

  SvgPicture _getSvgIcon({required Color backgroundColor, required Color color}){
    String iconName = currentIcon.iconName;
    if (currentIcon == MyIcon.plus) {
      return SvgPicture.asset("${Paths.iconFolderPath}$iconName",
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    } else {
      return SvgPicture.asset("${Paths.iconFolderPath}$iconName",
        colorFilter: ColorFilter.mode(backgroundColor, BlendMode.srcIn),
      );
    }
  }

  MyIcon get currentIcon => widget.controller.completedStateWillChange(widget.entry, widget.entry.progress + 1) && widget.entry.rule.type != CompletionType.atMost ? MyIcon.completed : MyIcon.plus;

}
