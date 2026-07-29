import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class MentorThinking extends StatelessWidget {
  const MentorThinking({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text('MENTOR', style: AppTypography.overline),
        const SizedBox(width: AppSpacing.md),
        Row(
          children: List.generate(3, (i) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.textSecondary,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(
                    onPlay: (c) => c.repeat(),
                    delay: Duration(milliseconds: i * 180),
                  )
                  .fadeOut(duration: 600.ms, curve: Curves.easeOut)
                  .then()
                  .fadeIn(duration: 600.ms, curve: Curves.easeIn),
            );
          }),
        ),
      ],
    );
  }
}
