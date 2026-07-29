import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/storage_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/breathing_background.dart';
import '../../../core/widgets/brutal_button.dart';
import '../../../core/widgets/fade_in.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const _slides = <_Slide>[
    _Slide(
      eyebrow: 'BRUTAL MODE',
      title: 'A calm operating system\nfor your life.',
      body:
          'Discipline doesn\'t shout. It shows up — quietly, every day.',
    ),
    _Slide(
      eyebrow: 'MENTOR',
      title: 'One trusted voice.\nNo noise.',
      body:
          'An AI mentor that knows your patterns and gives you one clear next step.',
    ),
    _Slide(
      eyebrow: 'GROWTH',
      title: 'Identity over\nmotivation.',
      body:
          'Track what compounds. Streaks, focus, sleep — measured, never gamified.',
    ),
  ];

  void _next() async {
    if (_index < _slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 480),
        curve: Curves.easeOutCubic,
      );
    } else {
      await StorageService.instance.setBool(StorageKeys.onboardingComplete, true);
      if (!mounted) return;
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BreathingBackground(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => _SlideView(slide: _slides[i]),
              ),
            ),
            _Dots(active: _index, count: _slides.length),
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pageGutter,
              ),
              child: BrutalButton(
                label: _index == _slides.length - 1 ? 'Begin' : 'Continue',
                expanded: true,
                size: BrutalButtonSize.large,
                onPressed: _next,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Slide {
  const _Slide({
    required this.eyebrow,
    required this.title,
    required this.body,
  });
  final String eyebrow;
  final String title;
  final String body;
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide});
  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 28,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 28,
            ),
          )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scaleXY(begin: 0.96, end: 1.04, duration: 3.seconds),
          const SizedBox(height: AppSpacing.huge),
          FadeInUp(
            child: Text(slide.eyebrow, style: AppTypography.overline),
          ),
          const SizedBox(height: AppSpacing.md),
          FadeInUp(
            delay: const Duration(milliseconds: 60),
            child: Text(slide.title, style: AppTypography.displayMedium),
          ),
          const SizedBox(height: AppSpacing.lg),
          FadeInUp(
            delay: const Duration(milliseconds: 120),
            child: Text(
              slide.body,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.active, required this.count});
  final int active;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 26 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.accent : AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
