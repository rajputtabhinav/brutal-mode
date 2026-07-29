import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';

class HabitsNotifier extends Notifier<List<Habit>> {
  @override
  List<Habit> build() {
    return const [
      Habit(
        id: 'sleep',
        name: 'Sleep 7h+',
        icon: '◐',
        currentStreak: 12,
        completedToday: true,
        history: [
          true, true, true, false, true, true, true,
          true, true, true, true, true, true, true,
        ],
      ),
      Habit(
        id: 'meditation',
        name: 'Meditate 10m',
        icon: '○',
        currentStreak: 5,
        completedToday: false,
        history: [
          true, true, false, true, true, true, false,
          true, true, false, true, true, true, true,
        ],
      ),
      Habit(
        id: 'movement',
        name: 'Movement',
        icon: '◇',
        currentStreak: 23,
        completedToday: true,
        history: [
          true, true, true, true, true, true, true,
          true, true, true, true, true, true, true,
        ],
      ),
      Habit(
        id: 'reading',
        name: 'Read 30m',
        icon: '▢',
        currentStreak: 3,
        completedToday: false,
        history: [
          true, false, true, true, false, true, true,
          true, false, true, true, false, true, true,
        ],
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final h in state)
        if (h.id == id)
          h.copyWith(
            completedToday: !h.completedToday,
            currentStreak: h.completedToday
                ? (h.currentStreak - 1).clamp(0, 9999)
                : h.currentStreak + 1,
          )
        else
          h,
    ];
  }
}

final habitsProvider =
    NotifierProvider<HabitsNotifier, List<Habit>>(HabitsNotifier.new);

final longestStreakProvider = Provider<int>((ref) {
  final habits = ref.watch(habitsProvider);
  if (habits.isEmpty) return 0;
  return habits.map((h) => h.currentStreak).reduce((a, b) => a > b ? a : b);
});
