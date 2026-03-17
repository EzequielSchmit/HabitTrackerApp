import 'package:habit_tracker_app/model/habit.dart';

abstract class HabitRepository {

  Future<Habit?> getHabitById(int habitId);
  Future<List<Habit>> getHabits();
  ///<code>saveHabit</code>: Si el hábito pasado por parámetro existe, se actualiza, sino se crea. Siempre se devuelve el hábito guardado.
  Future<Habit> saveHabit(Habit habit);
  Future<void> deleteHabit(Habit habit);

}