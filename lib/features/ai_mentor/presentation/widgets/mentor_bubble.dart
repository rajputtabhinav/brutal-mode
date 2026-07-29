import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../models/mentor_message.dart';

class MentorBubble extends StatelessWidget {
  const MentorBubble({super.key, required this.message});

  final MentorMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MentorSender.user;

    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppRadius.lg),
                topRight: Radius.circular(AppRadius.lg),
                bottomLeft: Radius.circular(AppRadius.lg),
                bottomRight: Radius.circular(6),
              ),
              border: Border.all(
                color: AppColors.stroke.withValues(alpha: 0.6),
                width: 0.5,
              ),
            ),
            child: Text(
              message.content,
              style: AppTypography.bodyMedium.copyWith(height: 1.5),
            ),
          ),
        ),
      );
    }

    // Mentor reply — no bubble, just typographic presence.
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message.content,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textPrimary,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
