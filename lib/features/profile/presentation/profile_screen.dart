import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/emotional_theme.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/brutal_card.dart';
import '../../../core/widgets/fade_in.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);

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
                      Text('YOU', style: AppTypography.overline),
                      const SizedBox(height: AppSpacing.sm),
                      Text(profile.name, style: AppTypography.headlineLarge),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        profile.disciplineGoal,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
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
                  child: _EmotionalStatePicker(
                    selected: profile.emotionalState,
                    onSelect: (s) => ref
                        .read(userProfileProvider.notifier)
                        .setEmotionalState(s),
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
                  delay: const Duration(milliseconds: 140),
                  child: _ActionList(
                    items: [
                      _ActionItem(
                        icon: Icons.nightlight_outlined,
                        label: 'Night Reflection',
                        sub: 'Close the day with intent.',
                        onTap: () => context.push('/reflection'),
                      ),
                      _ActionItem(
                        icon: Icons.notifications_outlined,
                        label: 'Notifications',
                        sub: 'Quiet, intentional nudges.',
                        onTap: () {},
                      ),
                      _ActionItem(
                        icon: Icons.bolt_outlined,
                        label: 'Discipline goal',
                        sub: profile.disciplineGoal,
                        onTap: () {},
                      ),
                      _ActionItem(
                        icon: Icons.shield_outlined,
                        label: 'Privacy',
                        sub: 'Your data, your terms.',
                        onTap: () {},
                      ),
                    ],
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

class _EmotionalStatePicker extends StatelessWidget {
  const _EmotionalStatePicker({
    required this.selected,
    required this.onSelect,
  });

  final EmotionalState selected;
  final ValueChanged<EmotionalState> onSelect;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('HOW YOU FEEL', style: AppTypography.overline),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'The app adapts subtly.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final s in EmotionalState.values)
                _StateChip(
                  state: s,
                  selected: s == selected,
                  onTap: () => onSelect(s),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StateChip extends StatelessWidget {
  const _StateChip({
    required this.state,
    required this.selected,
    required this.onTap,
  });

  final EmotionalState state;
  final bool selected;
  final VoidCallback onTap;

  String get _label => switch (state) {
        EmotionalState.neutral => 'Neutral',
        EmotionalState.stressed => 'Stressed',
        EmotionalState.productive => 'Productive',
        EmotionalState.recovering => 'Recovering',
      };

  Color get _accent => switch (state) {
        EmotionalState.neutral => AppColors.accent,
        EmotionalState.stressed => AppColors.focus,
        EmotionalState.productive => AppColors.accentSoft,
        EmotionalState.recovering => AppColors.recovery,
      };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceElevated : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected
                ? _accent.withValues(alpha: 0.7)
                : AppColors.stroke,
            width: selected ? 1 : 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _accent,
                shape: BoxShape.circle,
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: _accent.withValues(alpha: 0.6),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _label,
              style: AppTypography.labelLarge.copyWith(
                color: selected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionItem {
  const _ActionItem({
    required this.icon,
    required this.label,
    required this.sub,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String sub;
  final VoidCallback onTap;
}

class _ActionList extends StatelessWidget {
  const _ActionList({required this.items});
  final List<_ActionItem> items;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            InkWell(
              onTap: items[i].onTap,
              borderRadius: i == 0
                  ? const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg))
                  : i == items.length - 1
                      ? const BorderRadius.vertical(
                          bottom: Radius.circular(AppRadius.lg))
                      : BorderRadius.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Icon(
                      items[i].icon,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(items[i].label,
                              style: AppTypography.bodyLarge),
                          const SizedBox(height: 4),
                          Text(items[i].sub,
                              style: AppTypography.labelMedium),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            ),
            if (i < items.length - 1)
              const Divider(height: 0.5, indent: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}
