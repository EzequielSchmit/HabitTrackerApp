import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/color_extension.dart';

class FakeHabitRepository extends HabitRepository {

  final List<Habit> _habits = [];
  int _nextId = 0;
  int generateNextId() => _nextId++;

  FakeHabitRepository(){
    //Datos de prueba:

    DateTime now, today;
    now = DateTime.now();
    today = DateTime(now.year, now.month, now.day);

    //Habito "positivo"
    Habit habit = Habit(id: 1, name: "Tomar vasos de agua", color: ColorExtension.habitsColors[1]);
    CompletionRule r1 = CompletionRule(completionTarget: 3, startDate: today.add(Duration(days: -10)));
    habit.addRule(r1);
    saveHabit(habit);
    
    //Habito "positivo trivial"
    Habit habitT = Habit(id: 2, name: "Hacer la cama", color: ColorExtension.habitsColors[2]);
    CompletionRule r2 = CompletionRule(completionTarget: 1, type: CompletionType.atLeast, startDate: today.add(Duration(days: -10)));
    habitT.addRule(r2);
    saveHabit(habitT);

    //Habito "negativo"
    Habit habitN = Habit(id: 3, name: "Fumar cigarrillos", color: ColorExtension.habitsColors[3]);
    CompletionRule r3 = CompletionRule(completionTarget: 3, type: CompletionType.atMost, startDate: today.add(Duration(days: -10)));
    habitN.addRule(r3);
    saveHabit(habitN);

    //Habito "negativo trivial"
    Habit habitNT = Habit(id: 4, name: "Estar horas en insta en hora buena xd lol", color: ColorExtension.habitsColors[4]);
    CompletionRule r4 = CompletionRule(completionTarget: 1, type: CompletionType.atMost, startDate: today.add(Duration(days: -10)));
    habitNT.addRule(r4);
    saveHabit(habitNT);

    //Habito "negativo total"
    Habit habitNTotal = Habit(id: 5, name: "Tratar mal a alguien", color: ColorExtension.habitsColors[5]);
    CompletionRule r5 = CompletionRule(completionTarget: 0, type: CompletionType.atMost, startDate: today.add(Duration(days: -10)));
    habitNTotal.addRule(r5);
    saveHabit(habitNTotal);

  }

  @override
  Future<Habit?> getHabitById(int habitId) async {
    Iterable<Habit> iterable = _habits.where( (h) => h.id == habitId,);
    return iterable.isEmpty ? null : iterable.first.copyWith();
  }

  @override
  Future<List<Habit>> getHabits() async {
    return [..._habits].map((e) => e.copyWith(),).toList();
  }
  
  @override
  Future<Habit> saveHabit(Habit habit) async {
    Habit newHabit = habit;
    int habitIndex = _habits.indexWhere( (h) => habit.id == h.id, );
    if (habitIndex != -1) {
      _habits[habitIndex] = newHabit;
    } else {
      newHabit = newHabit.copyWith(id: generateNextId());
      _habits.add(newHabit);
    }
    return newHabit.copyWith();
  }

  @override
  Future<void> deleteHabit(int habitId) async {
    _habits.removeWhere((h) => h.id == habitId,);
  }
}