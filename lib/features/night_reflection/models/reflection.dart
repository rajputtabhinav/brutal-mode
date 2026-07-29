import 'package:equatable/equatable.dart';

enum Mood { drained, low, steady, focused, energized }

extension MoodCopy on Mood {
  String get label => switch (this) {
        Mood.drained => 'Drained',
        Mood.low => 'Low',
        Mood.steady => 'Steady',
        Mood.focused => 'Focused',
        Mood.energized => 'Energized',
      };

  String get glyph => switch (this) {
        Mood.drained => '⊝',
        Mood.low => '◌',
        Mood.steady => '○',
        Mood.focused => '◐',
        Mood.energized => '●',
      };
}

class Reflection extends Equatable {
  const Reflection({
    required this.id,
    required this.date,
    required this.mood,
    required this.wins,
    required this.challenges,
    required this.tomorrowFocus,
    this.aiSummary,
  });

  final String id;
  final DateTime date;
  final Mood mood;
  final String wins;
  final String challenges;
  final String tomorrowFocus;
  final String? aiSummary;

  @override
  List<Object?> get props =>
      [id, date, mood, wins, challenges, tomorrowFocus, aiSummary];
}
