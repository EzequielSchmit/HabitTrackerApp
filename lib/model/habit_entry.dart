import 'dart:math';

import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';

class HabitEntry {

  HabitEntry({required this.id, required this.habit, required DateTime date, required int progress}) : _progress = progress {
    this.date = DateTime(date.year, date.month, date.day);
  }

  final int? id;
  final Habit habit;
  late final DateTime date;
  int _progress;

  String getFrequencyDescription() {
    //Implementar
    int target = rule.completionTarget;
    return rule.type != CompletionType.atMost ? "Cada día" : (target > 0 ? "Máximo $target ${target==1 ? "vez" : "veces"}" : "Nunca");
  }

  void undoComplete() {
    if (rule.type == CompletionType.atMost) {
      progress++;
    } else {
      progress = 0;
    }
  }

  int getProgressPercentage(){
    return rule.getProgressPercentage(progress);
  }

  ///<code>rule</code>: Es la regla asociada a esta entrada. Depende del habito y la fecha asociada.
  CompletionRule get rule => habit.getRuleByDate(date);

  ///<code>cpmpleted</code>: Devuelve si el habito se completó segun la regla asociada a esta entrada.
  bool get completed {
    return rule.isCompleted(progress);
  }

  int get progress => _progress;

  set progress(int val) {
    if (val >= 0) _progress = val;
  }
}