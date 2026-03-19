import 'dart:math';

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

  ///<code>fastLuminance</code>: Retorna un valor aproximado de la luminosidad del color. No realiza calculos complejos como la linealización o descompresión gamma.
  double get fastLuminance => r * 0.299 + g * 0.587 + b * 0.114;

  bool get isADarkColor => fastLuminance < 0.5;

  bool get isALightColor => !isADarkColor;

  Color get simpleVisibleColor => isADarkColor ? Colors.white : Colors.black;

  ///<code>withLuminance</code>:
  Color withLuminance(double desiredLuminance){
    double currentLuminance = fastLuminance;
    if (currentLuminance > 0) {
      double X = min(desiredLuminance/currentLuminance, 1/max(max(r, g), b));
      X = max(X, 0);
      return withValues(red: (X*r).clamp(0, 1), green: (X*g).clamp(0.0, 1.0), blue: (X*b).clamp(0.0, 1.0));
    } else {
      return withValues(red: desiredLuminance, green: desiredLuminance, blue: desiredLuminance);
    }
  }

  Color toGrayScale() {
    double currentLuminance = fastLuminance;
    return Colors.black.withLuminance(currentLuminance);
  }
}