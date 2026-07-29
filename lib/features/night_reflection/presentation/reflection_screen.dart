import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/services/posthog_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/brutal_button.dart';
import '../../../core/widgets/brutal_card.dart';
import '../../../core/widgets/fade_in.dart';
import '../models/reflection.dart';

class ReflectionScreen extends ConsumerStatefulWidget {
  const ReflectionScreen({super.key});

  @override
  ConsumerState<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends ConsumerState<ReflectionScreen> {
  Mood? _mood;
  final _wins = TextEditingController();
  final _challenges = TextEditingController();
  final _focus = TextEditingController();

  @override
  void dispose() {
    _wins.dispose();
    _challenges.dispose();
    _focus.dispose();
    super.dispose();
  }

  bool get _canSave => _mood != null;

  Future<void> _save() async {
    if (!_canSave) return;
    final r = Reflection(
      id: const Uuid().v4(),
      date: DateTime.now(),
      mood: _mood!,
      wins: _wins.text.trim(),
      challenges: _challenges.text.trim(),
      tomorrowFocus: _focus.text.trim(),
    );
    PostHogService.instance.reflectionSubmitted(mood: r.mood.label);
    if (!mounted) return;
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BreathingBackground(
      glowColor: AppColors.recovery,
      gradient: const LinearGradient(
        colors: [
          AppColors.background,
          Color(0xFF0F1311),
          AppColors.background,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 0.5, 1.0],
      ),
      child: SafeArea(
        child: Column(
          children: [
            _TopBar(onClose: () => context.pop()),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.lg,
                  AppSpacing.pageGutter,
                  AppSpacing.huge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      child: Text(
                        'NIGHT REFLECTION',
                        style: AppTypography.overline,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    FadeInUp(
                      delay: const Duration(milliseconds: 60),
                      child: Text(
                        'How did today land?',
                        style: AppTypography.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    FadeInUp(
                      delay: const Duration(milliseconds: 120),
                      child: _MoodPicker(
                        selected: _mood,
                        onSelect: (m) => setState(() => _mood = m),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionGap),
                    FadeInUp(
                      delay: const Duration(milliseconds: 180),
                      child: _Field(
                        label: 'WINS',
                        hint: 'What worked? Even small.',
                        controller: _wins,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FadeInUp(
                      delay: const Duration(milliseconds: 220),
                      child: _Field(
                        label: 'FRICTION',
                        hint: 'Where did you get stuck?',
                        controller: _challenges,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    FadeInUp(
                      delay: const Duration(milliseconds: 260),
                      child: _Field(
                        label: 'TOMORROW',
                        hint: 'One thing that matters.',
                        controller: _focus,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.huge),
                    FadeInUp(
                      delay: const Duration(milliseconds: 320),
                      child: BrutalButton(
                        label: 'Close the day',
                        expanded: true,
                        size: BrutalButtonSize.large,
                        onPressed: _canSave ? _save : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onClose});
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.pageGutter,
        AppSpacing.lg,
        AppSpacing.pageGutter,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close_rounded),
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _MoodPicker extends StatelessWidget {
  const _MoodPicker({required this.selected, required this.onSelect});

  final Mood? selected;
  final ValueChanged<Mood> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MOOD', style: AppTypography.overline),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final m in Mood.values)
              _MoodChip(
                mood: m,
                selected: selected == m,
                onTap: () => onSelect(m),
              ),
          ],
        ),
      ],
    );
  }
}

class _MoodChip extends StatelessWidget {
  const _MoodChip({
    required this.mood,
    required this.selected,
    required this.onTap,
  });

  final Mood mood;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        width: 52,
        height: 64,
        decoration: BoxDecoration(
          color: selected ? AppColors.surfaceElevated : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: selected
                ? AppColors.recovery.withValues(alpha: 0.6)
                : AppColors.stroke.withValues(alpha: 0.6),
            width: selected ? 1 : 0.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.recovery.withValues(alpha: 0.25),
                    blurRadius: 16,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mood.glyph,
              style: TextStyle(
                fontSize: 22,
                color: selected
                    ? AppColors.recovery
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              mood.label,
              style: AppTypography.labelMedium.copyWith(
                color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
  });

  final String label;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.overline),
        const SizedBox(height: AppSpacing.md),
        BrutalCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: TextField(
            controller: controller,
            maxLines: 3,
            minLines: 2,
            style: AppTypography.bodyLarge,
            cursorColor: AppColors.recovery,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: AppTypography.bodyLarge.copyWith(
                color: AppColors.textTertiary,
              ),
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        ),
      ],
    );
  }
}
