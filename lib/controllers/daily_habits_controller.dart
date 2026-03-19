import 'package:habit_tracker_app/data/repositories/habit_entry_repository.dart';
import 'package:habit_tracker_app/data/repositories/habit_repository.dart';
import 'package:habit_tracker_app/model/habit_entry.dart';

class DailyHabitsController {

  DailyHabitsController({required this.habitRepository, required this.entryRepository});

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

}