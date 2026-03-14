import 'dart:ffi';

import 'package:flutter/material.dart';

class Habit {
  const Habit({required this.name, required this.backgroundColor, required this.id });
  final int id;
  final String name;
  final Color backgroundColor;

  String getFrequencyDescription() {
    //Implementar
    return "Cada día";
  }

  static int _nextNewId = 0;
  static int getNewId(){
    return _nextNewId++;
  }
}