import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

extension ColorExtension on Color {
  static final List<Color> habitsColors = [
    Color(0xFF3f8fff),
    Color(0xFF66a3ff),
    Color(0xffff6b81),
    Color(0xffff9966),
    Color(0xff9466ff),
    Color(0xffff6666),
    Color(0xffff74c1),
    Color(0xffffc466),
  ];

  double get fastLuminance => r * 0.299 + g * 0.587 + b * 0.114;

  bool get isADarkColor => fastLuminance < 0.5;

  bool get isALightColor => !isADarkColor;

  Color get simpleVisibleColor => isADarkColor ? Colors.white : Colors.black;
  
}