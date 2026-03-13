import 'package:flutter/material.dart';

class Habit {
  const Habit({required this.name, required this.backgroundColor });
  final String name;
  final Color backgroundColor;

  String getFrequencyDescription() {
    //Implementar
    return "Cada día";
  }
}