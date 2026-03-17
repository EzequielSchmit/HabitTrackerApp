import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';

class Habit {

  Habit({required this.name, required this.backgroundColor, required this.id});
  final int id;
  final String name;
  final Color backgroundColor;
  final List<CompletionRule> rules = [];

  String getFrequencyDescription() {
    //Implementar
    return "Cada día";
  }

  ///
  ///Agrega la regla pasada por parámetro al hábito si no existe otra regla con fecha de inicio igual a la nueva regla.<br>
  ///Si la regla se agregó con exito devuelve <code>true</code>, de lo contrario, devuelve <code>false</code>.
  ///
  bool addRule(CompletionRule newRule){
    
    for (CompletionRule rule in rules){
      if (rule.startDate.isAtSameMomentAs(newRule.startDate)) return false;
    }
    rules.add(newRule);
    return true;
  }

  ///
  ///Busca la regla válida para la fecha pasada por parámetro y la devuelve si existe. Si no, devuelve una regla dummy, "CompletionRule.emptyRule".<br>
  ///Para que la regla sea válida, la fecha pasada por parámetro debe ser posterior o igual a la fecha de inicio de la regla.
  ///
  CompletionRule getRuleByDate(DateTime date){
    // List<CompletionRule> rules = this.rules.toList();
    rules.sort((a, b) => b.startDate.compareTo(a.startDate),);
    for (CompletionRule rule in rules){
      DateTime startDate = rule.startDate;
      if (!date.isBefore(startDate)) return rule;
    }
    return CompletionRule.emptyRule;
  }

  static int _nextNewId = 0;
  static int getNewId(){
    return _nextNewId++;
  }

  static final Habit emptyHabit = Habit(name: "Empty habit", backgroundColor: Colors.white, id: -1);
  
}