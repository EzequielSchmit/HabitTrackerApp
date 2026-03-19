import 'package:habit_tracker_app/data/repositories/habit_entry_repository.dart';
import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/exceptions/repository_exception.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';
import 'package:habit_tracker_app/util/date_time_extension.dart';

class FakeHabitEntryRepository extends HabitEntryRepository{

  FakeHabitEntryRepository({required HabitRepository habitRepository}) : _habitRepository = habitRepository{
    _entries = [];
    //Aca puedo cargar dias con un progreso ya hecho para testing
    //TODO: cargar datos
  }
  
  late final List<HabitEntry> _entries;
  final HabitRepository _habitRepository;
  int _nextId = 1;
  int generateNextId() => _nextId++;

  ///<code>_getEntryIndex</code>: Si existe una entrada que coincida con los datos pasados por parámetros, devuelve su índice en la lista de entradas, sino devuelve -1.
  int _getEntryIndex(int habitId, DateTime date) {
    int index = -1;
    for (int i = 0; i < _entries.length; i++){
      HabitEntry e = _entries[i];
      if (e.habit.id == habitId && e.date.isSameDay(date)){
        index = i;
        break;
      }
    }
    return index;
  }

  @override
  Future<HabitEntry?> getEntry(int habitId, DateTime date) async {
    int entryIndex = _getEntryIndex(habitId, date);
    return entryIndex == -1 ? null : _entries[entryIndex].copyWith();
  }
  
  @override
  Future<HabitEntry> getOrCreateEntry(int habitId, DateTime date) async {

    HabitEntry? entry = await getEntry(habitId, date);
    if (entry != null) {
      return entry.copyWith();
    }

    Habit? habit = await _habitRepository.getHabitById(habitId);
    if (habit == null){
      throw RepositoryException(message: "Entry couldn't be obtained nor created. There isn't a habit with that id.");
    }
    return saveEntry(HabitEntry(id: null, habit: habit, date: date, progress: 0));
  }

  @override
  Future<List<HabitEntry>> getEntriesByHabitId(int habitId) async {
    return _entries
      .where((e) => e.habit.id == habitId,)
      .map((e) => e.copyWith(),)
      .toList();
  }

  @override
  Future<List<HabitEntry>> getEntriesByDate(DateTime date) async {
    return _entries
      .where((e) => e.date.isSameDay(date),)
      .map((e) => e.copyWith(),)
      .toList();
  }

  @override
  Future<HabitEntry> saveEntry(HabitEntry entry) async {
    int? habitId = entry.habit.id;
    if (habitId == null) {
      throw RepositoryException(message: "Entry couldn't be saved. Habit id is invalid.");
    }
    
    HabitEntry updatedEntry = entry.copyWith(id: entry.id ?? generateNextId());
    int index = _getEntryIndex(habitId, entry.date);

    if (index != -1) {
      _entries[index] = updatedEntry;
    } else {
      _entries.add(updatedEntry);
    }
    return updatedEntry.copyWith();

  }
  
  @override
  Future<void> deleteEntry(int habitId, DateTime date) async {
    _entries.removeWhere( (e) => e.habit.id == habitId && e.date.isSameDay(date), );
  }

}