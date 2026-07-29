import 'package:equatable/equatable.dart';

class Habit extends Equatable {
  const Habit({
    required this.id,
    required this.name,
    required this.icon,
    required this.currentStreak,
    required this.completedToday,
    required this.history,
  });

  final String id;
  final String name;
  final String icon;
  final int currentStreak;
  final bool completedToday;

  /// Last N days, true = completed.
  final List<bool> history;

  Habit copyWith({
    int? currentStreak,
    bool? completedToday,
    List<bool>? history,
  }) {
    return Habit(
      id: id,
      name: name,
      icon: icon,
      currentStreak: currentStreak ?? this.currentStreak,
      completedToday: completedToday ?? this.completedToday,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, icon, currentStreak, completedToday, history];
}
