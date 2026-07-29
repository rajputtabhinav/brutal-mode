import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/brutal_card.dart';
import '../../../habits/models/habit.dart';

class HabitRow extends StatelessWidget {
  const HabitRow({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  final Habit habit;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      onTap: onToggle,
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              habit.icon,
              style: AppTypography.headlineSmall.copyWith(
                color: habit.completedToday
                    ? AppColors.accent
                    : AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(habit.name, style: AppTypography.bodyLarge),
                const SizedBox(height: 4),
                Text(
                  '${habit.currentStreak}-day streak',
                  style: AppTypography.labelMedium,
                ),
              ],
            ),
          ),
          _HistoryStrip(history: habit.history),
        ],
      ),
    );
  }
}

class _HistoryStrip extends StatelessWidget {
  const _HistoryStrip({required this.history});
  final List<bool> history;

  @override
  Widget build(BuildContext context) {
    final last = history.length > 7
        ? history.sublist(history.length - 7)
        : history;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final hit in last) ...[
          Container(
            width: 6,
            height: 18,
            decoration: BoxDecoration(
              color: hit ? AppColors.accent : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(3),
              boxShadow: hit
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.4),
                        blurRadius: 6,
                      ),
                    ]
                  : null,
            ),
          ),
          const SizedBox(width: 4),
        ],
      ],
    );
  }
}
