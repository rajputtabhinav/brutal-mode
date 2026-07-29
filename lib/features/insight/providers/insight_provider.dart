import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/openai_service.dart';
import '../../tasks/providers/tasks_provider.dart';
import '../../habits/providers/habits_provider.dart';

/// Daily AI insight — a single calm line, computed on demand.
///
/// Falls back to a curated offline line if OpenAI is not configured.
final dailyInsightProvider = FutureProvider<String>((ref) async {
  final score = ref.watch(disciplineScoreProvider);
  final streak = ref.watch(longestStreakProvider);
  final progress = ref.watch(todayProgressProvider);

  return OpenAiService.instance.dailyInsight(
    disciplineScore: score,
    streakDays: streak,
    focusConsistency: progress,
  );
});
