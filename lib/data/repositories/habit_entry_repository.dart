import 'package:habit_tracker_app/model/habit_entry.dart';

abstract class HabitEntryRepository {

  ///<code>getEntry</code>: Si existe una entrada cuyos datos coincidan con los pasados por parámetro, devuelve una copia de esa entrada. Sino devuelve null.
  Future<HabitEntry?> getEntry(int habitId, DateTime date);

  ///<code>getOrCreateEntry</code>: Si existe una entrada cuyos datos coincidan con los pasados por parámetro, devuelve una copia de esa entrada. Si no existe, y <code>habitId</code> corresponde a un hábito existente, crea la entrada y devuelve una copia de ella. <br>
  ///En caso de que <code>habitId</code> no coincida con un hábito existente, lanza la excepcion "RepositoryException".
  Future<HabitEntry> getOrCreateEntry(int habitId, DateTime date);

  ///<code>getEntriesByHabitId</code>: Devuelve una lista de copias de entradas cuyo id coincida con el id pasado por parámetro. 
  Future<List<HabitEntry>> getEntriesByHabitId(int habitId);

  ///<code>getEntriesByDate</code>: Devuelve una lista de copias de entradas cuya fecha coincida con la fecha pasada por parámetro.
  Future<List<HabitEntry>> getEntriesByDate(DateTime date);

  ///<code>saveEntry</code>: Si la entrada pasada por parámetro existe, se actualiza, sino se crea. En ambos casos se utilizan los datos de la entrada pasada por parámetro. Siempre devuelve una copia de la entrada guardada. <br>
  ///Si el hábito asociado a la entrada pasada por parametro es inválido, lanza una excepcion de tipo "RepositoryException".
  Future<HabitEntry> saveEntry(HabitEntry entry);

  ///<code>deleteEntry</code>: Elimina las entradas del repositorio cuyo hábito asociado tenga el mismo id que el id pasado por parámetro, y tambien cuya fecha coincida con la fecha pasada por parámetro.
  Future<void> deleteEntry(int habitId, DateTime date);
}