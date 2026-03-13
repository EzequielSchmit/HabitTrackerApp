import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';

class HabitEntry {

  HabitEntry({required this.habit, required this.date, required this.rule, required int progress}) : _progress = progress;

  final Habit habit;
  final DateTime date;
  final CompletionRule rule;
  int _progress;

  int get progress => _progress;

  void incrementProgress() {
    _progress++;
  }

  void decrementProgress() {
    if (_progress > 0) _progress--;
  }

  bool get completed {
    return rule.isCompleted(progress);
  }

}