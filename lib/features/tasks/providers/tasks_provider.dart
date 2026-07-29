import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';

final _uuid = const Uuid();

class TasksNotifier extends Notifier<List<BrutalTask>> {
  @override
  List<BrutalTask> build() {
    final now = DateTime.now();
    return [
      BrutalTask(
        id: _uuid.v4(),
        title: 'Deep work block — strategy doc',
        priority: TaskPriority.high,
        completed: false,
        createdAt: now,
        dueAt: now.add(const Duration(hours: 2)),
        tag: 'Focus',
      ),
      BrutalTask(
        id: _uuid.v4(),
        title: 'Morning run — 5km, zone 2',
        priority: TaskPriority.normal,
        completed: true,
        createdAt: now,
        tag: 'Body',
      ),
      BrutalTask(
        id: _uuid.v4(),
        title: 'Read 30 minutes',
        priority: TaskPriority.normal,
        completed: false,
        createdAt: now,
        tag: 'Mind',
      ),
      BrutalTask(
        id: _uuid.v4(),
        title: 'Review weekly metrics',
        priority: TaskPriority.low,
        completed: false,
        createdAt: now,
        tag: 'Growth',
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(completed: !t.completed) else t,
    ];
  }

  void add(String title, {TaskPriority priority = TaskPriority.normal}) {
    state = [
      ...state,
      BrutalTask(
        id: _uuid.v4(),
        title: title,
        priority: priority,
        completed: false,
        createdAt: DateTime.now(),
      ),
    ];
  }

  void remove(String id) {
    state = state.where((t) => t.id != id).toList();
  }
}

final tasksProvider =
    NotifierProvider<TasksNotifier, List<BrutalTask>>(TasksNotifier.new);

/// Today's progress: completed / total.
final todayProgressProvider = Provider<double>((ref) {
  final tasks = ref.watch(tasksProvider);
  if (tasks.isEmpty) return 0;
  final done = tasks.where((t) => t.completed).length;
  return done / tasks.length;
});

/// Discipline score 0–100 — combines task completion, streak, and consistency.
/// Real implementation would aggregate across days; here it's a clean signal.
final disciplineScoreProvider = Provider<int>((ref) {
  final progress = ref.watch(todayProgressProvider);
  // Baseline 40 + up to 60 from today's completion.
  return (40 + progress * 60).round().clamp(0, 100);
});
