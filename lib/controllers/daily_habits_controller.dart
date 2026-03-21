import 'package:habit_tracker_app/data/repositories/habit_entry_repository.dart';
import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/model/completion_rule.dart';
import 'package:habit_tracker_app/model/habit.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';

class DailyHabitsController {

  DailyHabitsController({required this.habitRepository, required this.entryRepository}){
    print("Creando controller...");
  }

  final HabitEntryRepository entryRepository;
  final HabitRepository habitRepository;

  Future<bool> setProgress(HabitEntry entry, int newProgress) async {
    bool wasCompleted = entry.completed;
    entry.progress = newProgress;
    await entryRepository.saveEntry(entry);
    return wasCompleted != entry.completed;
  }

  Future<bool> incrementProgress(HabitEntry entry) async {
    return setProgress(entry, entry.progress+1);
  }

  Future<bool> decrementProgress(HabitEntry entry) async {
    return setProgress(entry, entry.progress-1);
  }

  bool isAboutToBeCompleted(HabitEntry entry) {
    return (entry.rule.type != CompletionType.atMost) && (entry.progress + 1 == entry.rule.completionTarget);
  }

  Future<List<Habit>> getHabits() async {
    return habitRepository.getHabits();
  }

  Future<List<HabitEntry>> getEntriesByDate(DateTime date) async {
    List<Habit> habits = await getHabits();
    List<HabitEntry> entries = await entryRepository.getEntriesByDate(date);
    final currentHabitsIdSet = entries.map((e) => e.habit.id,).toSet();

    for (Habit h in habits){
      int? habitId = h.id;
      if (habitId != null && !currentHabitsIdSet.contains(habitId)){
        HabitEntry newEntry = await entryRepository.getOrCreateEntry(habitId, date);
        entries.add(newEntry);
      }
    }

    return entries;
  }

}