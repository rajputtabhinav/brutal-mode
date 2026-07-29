import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/brutal_card.dart';
import '../../../core/widgets/fade_in.dart';
import '../../habits/providers/habits_provider.dart';
import '../../tasks/providers/tasks_provider.dart';
import 'widgets/habit_row.dart';
import 'widgets/stat_block.dart';

class GrowthScreen extends ConsumerWidget {
  const GrowthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(disciplineScoreProvider);
    final streak = ref.watch(longestStreakProvider);
    final habits = ref.watch(habitsProvider);

    return BreathingBackground(
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.lg,
                AppSpacing.pageGutter,
                AppSpacing.xxl,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GROWTH', style: AppTypography.overline),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Identity over time.',
                        style: AppTypography.headlineLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 80),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatBlock(
                          label: 'Discipline',
                          value: '$score',
                          unit: '/100',
                          accent: AppColors.accent,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: StatBlock(
                          label: 'Longest streak',
                          value: '$streak',
                          unit: 'days',
                          accent: AppColors.accentSoft,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.sectionGap),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 160),
                  child: const _ConsistencyCard(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.sectionGap),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 220),
                  child: Row(
                    children: [
                      Text('HABITS', style: AppTypography.overline),
                      const Spacer(),
                      Text(
                        '${habits.where((h) => h.completedToday).length}/${habits.length} today',
                        style: AppTypography.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
              ),
              sliver: SliverList.separated(
                itemCount: habits.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (_, i) => FadeInUp(
                  delay: Duration(milliseconds: 260 + i * 60),
                  child: HabitRow(
                    habit: habits[i],
                    onToggle: () =>
                        ref.read(habitsProvider.notifier).toggle(habits[i].id),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 120)),
          ],
        ),
      ),
    );
  }
}

class _ConsistencyCard extends StatelessWidget {
  const _ConsistencyCard();

  static const _values = <double>[
    0.4, 0.55, 0.5, 0.7, 0.65, 0.8, 0.78,
    0.82, 0.7, 0.85, 0.9, 0.88, 0.92, 0.95,
  ];

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      gradient: AppColors.cardGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CONSISTENCY · 14 DAYS', style: AppTypography.overline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Focus, sleep, movement — combined.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            height: 140,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: const LineTouchData(enabled: false),
                minY: 0,
                maxY: 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < _values.length; i++)
                        FlSpot(i.toDouble(), _values[i]),
                    ],
                    isCurved: true,
                    curveSmoothness: 0.32,
                    color: AppColors.accent,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.accent.withValues(alpha: 0.25),
                          AppColors.accent.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
