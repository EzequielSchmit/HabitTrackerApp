import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';

class HabitEntry {

  HabitEntry({required this.habit, required DateTime date, required this.rule, required int progress}) : _progress = progress {
    this.date = DateTime(date.year, date.month, date.day);
  }

  final Habit habit;
  late final DateTime date;
  final CompletionRule rule;
  int _progress;

  int get progress => _progress;

  set progress(int val) {
    if (val >= 0) _progress = val;
  }

  // void incrementProgress() {
  //   _progress++;
  // }

  // void decrementProgress() {
  //   if (_progress > 0) _progress--;
  // }

  bool get completed {
    return rule.isCompleted(progress);
  }

  int getProgressPercentage(int progress) => (100*progress/rule.completionTarget).floor();

  // bool isAboutToBeCompleted(){
  //   return progress >= rule.completionTarget - 1;
  // }

  String get id => "${habit.id}${date.year}/${date.month}/${date.day}";

}