import 'package:habit_tracker_app/model/habit.dart';

class CompletionRule {

  CompletionRule({required this.id, required this.completionTarget, required DateTime startDate, this.completedByExcess = true, this.isLimitedByTarget = false}){
    this.startDate = DateTime(startDate.year, startDate.month, startDate.day);
  }

  final int id;
  final int completionTarget;
  final bool completedByExcess;
  final bool isLimitedByTarget;
  late final DateTime startDate;

  bool isCompleted(int progress){
    return completedByExcess? progress >= completionTarget : progress < completionTarget;
  }

  bool get trivial => completionTarget == 1;

  static final CompletionRule emptyRule = CompletionRule(id: -1, completionTarget: 0, startDate: DateTime.fromMillisecondsSinceEpoch(0));
  static final DateTime infinitePast = DateTime.fromMillisecondsSinceEpoch(0);
  static final DateTime infiniteFuture = DateTime(2970);

}