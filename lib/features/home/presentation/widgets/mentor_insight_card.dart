import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/brutal_card.dart';

class MentorInsightCard extends StatelessWidget {
  const MentorInsightCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BrutalCard(
      onTap: onTap,
      gradient: AppColors.cardGradient,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.accentGradient,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                'MENTOR',
                style: AppTypography.overline,
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.textSecondary,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Your focus consistency improved this week.',
            style: AppTypography.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Tap to explore what shifted, and what to sharpen next.',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}
