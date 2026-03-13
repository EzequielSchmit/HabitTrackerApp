import 'package:habit_tracker_app/model/habit.dart';

class CompletionRule {

  CompletionRule({required this.id, required this.habit, required this.completionTarget, required this.startDate, required this.endDate, this.completedByExcess = true});

  final int id;
  final Habit habit;
  final int completionTarget;
  final bool completedByExcess;
  final DateTime startDate, endDate;

  bool isCompleted(int progress){
    return completedByExcess? progress >= completionTarget : progress < completionTarget;
  }

}