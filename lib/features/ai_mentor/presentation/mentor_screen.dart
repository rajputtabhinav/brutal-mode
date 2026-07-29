import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/fade_in.dart';
import '../models/mentor_message.dart';
import '../providers/mentor_provider.dart';
import 'widgets/mentor_bubble.dart';
import 'widgets/mentor_composer.dart';
import 'widgets/mentor_thinking.dart';

class MentorScreen extends ConsumerStatefulWidget {
  const MentorScreen({super.key});

  @override
  ConsumerState<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends ConsumerState<MentorScreen> {
  final _scroll = ScrollController();

  void _jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mentorProvider);
    ref.listen(mentorProvider, (_, __) => _jumpToEnd());

    return BreathingBackground(
      child: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.pageGutter,
                  AppSpacing.lg,
                  AppSpacing.pageGutter,
                  AppSpacing.lg,
                ),
                itemCount: state.messages.length + (state.isThinking ? 1 : 0),
                itemBuilder: (context, i) {
                  if (i == state.messages.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                      child: MentorThinking(),
                    );
                  }
                  final msg = state.messages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: MentorBubble(message: msg),
                  );
                },
              ),
            ),
            if (state.messages.length <= 1)
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: const _Suggestions(),
              ),
            MentorComposer(
              onSend: (text) {
                ref.read(mentorProvider.notifier).send(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

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
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.accentGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.35),
                  blurRadius: 18,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(
                begin: 0.97,
                end: 1.03,
                duration: 3.seconds,
                curve: Curves.easeInOut,
              ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mentor', style: AppTypography.headlineSmall),
              Text(
                'Calm. Honest. On your side.',
                style: AppTypography.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Suggestions extends ConsumerWidget {
  const _Suggestions();

  static const _prompts = [
    'What\'s draining my focus this week?',
    'Plan a 90-minute deep work block.',
    'Help me reset after a rough day.',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.pageGutter,
        ),
        itemCount: _prompts.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () =>
                ref.read(mentorProvider.notifier).send(_prompts[i]),
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(
                  color: AppColors.stroke.withValues(alpha: 0.6),
                  width: 0.5,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _prompts[i],
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
