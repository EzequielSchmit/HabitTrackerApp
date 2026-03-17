import 'package:habit_tracker_app/model/habit_entry.dart';

abstract class HabitEntryRepository {

  Future<HabitEntry?> getEntry(int habitId, DateTime date);
  Future<HabitEntry> getOrCreateEntry(int habitId, DateTime date);
  Future<List<HabitEntry>> getEntriesByHabitId(int habitId);
  Future<List<HabitEntry>> getEntriesByDate(DateTime date);
  ///<code>saveEntry</code>: Si la entrada pasada por parámetro existe, se actualiza, sino se crea. Siempre se devuelve la entrada guardada.
  Future<HabitEntry> saveEntry(HabitEntry entry);
  Future<void> deleteEntry(int habitId, DateTime date);
}