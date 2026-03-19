import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/model/habit.dart';

class FakeHabitRepository extends HabitRepository {

  final List<Habit> _habits = [];
  int _nextId = 0;
  int generateNextId() => _nextId++;

  FakeHabitRepository(){
    //Aca cargaria los datos a la lista _habits
  }

  @override
  Future<Habit?> getHabitById(int habitId) async {
    Iterable<Habit> iterable = _habits.where( (h) => h.id == habitId,);
    return iterable.isEmpty ? null : iterable.first;
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
    return newHabit;
  }

  @override
  Future<void> deleteHabit(int habitId) async {
    _habits.removeWhere((h) => h.id == habitId,);
  }
}