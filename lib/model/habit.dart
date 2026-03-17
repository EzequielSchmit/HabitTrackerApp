import 'package:flutter/material.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';

class Habit {

  Habit({required this.id, required this.name, required this.color, List<CompletionRule>? rules}) : _rules = rules ?? [];
  final int? id;
  final String name;
  final Color color;
  final List<CompletionRule> _rules;

  String getFrequencyDescription() {
    //Implementar
    return "Cada día";
  }

  ///
  ///Agrega la regla pasada por parámetro al hábito si no existe otra regla con fecha de inicio igual a la nueva regla.<br>
  ///Si la regla se agregó con exito devuelve <code>true</code>, de lo contrario, devuelve <code>false</code>.
  ///
  bool addRule(CompletionRule newRule){
    for (CompletionRule rule in _rules){
      if (rule.startDate.isAtSameMomentAs(newRule.startDate)) return false;
    }
    _rules.add(newRule);
    return true;
  }

  bool deleteRule(CompletionRule rule){
    return _rules.remove(rule);
  }

  List<CompletionRule> get rules => [..._rules];

  ///
  ///Busca la regla válida para la fecha pasada por parámetro y la devuelve si existe. Si no, devuelve una regla dummy, "CompletionRule.emptyRule".<br>
  ///Para que la regla sea válida, la fecha pasada por parámetro debe ser posterior o igual a la fecha de inicio de la regla.
  ///
  CompletionRule getRuleByDate(DateTime date){
    List<CompletionRule> rules = this.rules..sort((a, b) => b.startDate.compareTo(a.startDate),);
    for (CompletionRule rule in rules){
      DateTime startDate = rule.startDate;
      if (!date.isBefore(startDate)) return rule;
    }
    return CompletionRule.emptyRule;
  }

  Habit copyWith({int? id, String? name, Color? color, List<CompletionRule>? rules}){
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      rules: rules ?? this.rules,
    );
  }

  static final Habit emptyHabit = Habit(id: null, name: "Empty habit", color: Colors.white);
  
}