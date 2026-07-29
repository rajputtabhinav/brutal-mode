import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.name,
    required this.date,
  });

  final String name;
  final String date;

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 5) return 'Still up, $name.';
    if (h < 12) return 'Good morning, $name.';
    if (h < 17) return 'Good afternoon, $name.';
    if (h < 22) return 'Good evening, $name.';
    return 'Wind down, $name.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date.toUpperCase(),
          style: AppTypography.overline,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _greeting,
          style: AppTypography.headlineLarge,
        ),
      ],
    );
  }
}
