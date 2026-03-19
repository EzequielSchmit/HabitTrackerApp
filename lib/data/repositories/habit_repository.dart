import 'package:habit_tracker_app/model/habit.dart';

abstract class HabitRepository {
  
  ///<code>getHabitById</code>: Si existe un hábito cuyo id coincida con el id pasado por parametro, devuelve una copia de ese hábito. Sino, devuelve null.
  Future<Habit?> getHabitById(int habitId);

  ///<code>getHabits</code>: Retorna un lista de copias de los hábitos guardados en el repositorio.
  Future<List<Habit>> getHabits();

  ///<code>saveHabit</code>: Si el hábito pasado por parámetro existe, se actualiza, sino se crea. Siempre se devuelve una copia del hábito guardado.
  Future<Habit> saveHabit(Habit habit);

  ///<code>deleteHabit</code>: Elimina los hábitos del repositorio que tengan el mismo id que el id pasado por parámetro.
  Future<void> deleteHabit(int habitId);

}