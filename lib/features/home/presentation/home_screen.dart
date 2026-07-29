import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/brutal_card.dart';
import '../../../core/widgets/brutal_progress_ring.dart';
import '../../../core/widgets/fade_in.dart';
import '../../insight/providers/insight_provider.dart';
import '../../profile/providers/user_provider.dart';
import '../../tasks/providers/tasks_provider.dart';
import 'widgets/home_header.dart';
import 'widgets/mentor_insight_card.dart';
import 'widgets/task_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emo = ref.watch(emotionalThemeProvider);
    final profile = ref.watch(userProfileProvider);
    final tasks = ref.watch(tasksProvider);
    final progress = ref.watch(todayProgressProvider);
    final score = ref.watch(disciplineScoreProvider);
    final insight = ref.watch(dailyInsightProvider);

    final unfinishedTasks =
        tasks.where((t) => !t.completed).take(3).toList(growable: false);

    return BreathingBackground(
      gradient: emo.ambientGradient,
      glowColor: emo.accent,
      child: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                AppSpacing.lg,
                AppSpacing.pageGutter,
                AppSpacing.sm,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  child: HomeHeader(
                    name: profile.name,
                    date: DateFormat('EEEE, MMMM d').format(DateTime.now()),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.lg,
                ),
                child: Center(
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 120),
                    child: BrutalProgressRing(
                      progress: progress,
                      disciplineScore: score,
                      accent: emo.accent,
                    ),
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
                  delay: const Duration(milliseconds: 240),
                  child: insight.when(
                    data: (text) => _Insight(text: text),
                    loading: () =>
                        const _Insight(text: 'Listening to your day…'),
                    error: (_, __) => const _Insight(
                      text: 'Small actions become identity.',
                    ),
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
                  delay: const Duration(milliseconds: 320),
                  child: Row(
                    children: [
                      Text(
                        'TODAY',
                        style: AppTypography.overline,
                      ),
                      const Spacer(),
                      Text(
                        '${tasks.where((t) => t.completed).length}/${tasks.length} complete',
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
                itemBuilder: (_, i) => FadeInUp(
                  delay: Duration(milliseconds: 360 + i * 80),
                  child: TaskTile(
                    task: unfinishedTasks[i],
                    onToggle: () =>
                        ref.read(tasksProvider.notifier).toggle(
                              unfinishedTasks[i].id,
                            ),
                  ),
                ),
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemCount: unfinishedTasks.length,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.sectionGap),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.pageGutter,
                0,
                AppSpacing.pageGutter,
                120,
              ),
              sliver: SliverToBoxAdapter(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 640),
                  child: MentorInsightCard(
                    onTap: () => context.go('/mentor'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Insight extends StatelessWidget {
  const _Insight({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.cardPadding,
        vertical: AppSpacing.lg,
      ),
      gradient: AppColors.cardGradient,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 36,
            margin: const EdgeInsets.only(right: AppSpacing.lg, top: 2),
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
