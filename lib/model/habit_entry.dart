import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';

class HabitEntry {

  HabitEntry({required this.habit, required DateTime date, required int progress}) : _progress = progress {
    this.date = DateTime(date.year, date.month, date.day);
  }

  final Habit habit;
  late final DateTime date;
  int _progress;
  CompletionRule _rule = CompletionRule.emptyRule;



  int getProgressPercentage(int progress) => (100*progress/rule.completionTarget).floor();



  CompletionRule get rule {
    if (_rule != CompletionRule.emptyRule) return _rule;
    _rule = habit.getRuleByDate(date);
    return _rule;
  }

  bool get completed {
    return rule.isCompleted(progress);
  }

  String get id => "${habit.id}${date.year}/${date.month}/${date.day}";

  int get progress => _progress;

  set progress(int val) {
    if (val >= 0) _progress = val;
  }
}