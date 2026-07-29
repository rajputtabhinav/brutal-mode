import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

/// A premium card surface. Soft, dark, minimal shadow.
/// Variants for elevated, subtle gradient, and outlined.
class BrutalCard extends StatelessWidget {
  const BrutalCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.gradient,
    this.color,
    this.border,
    this.borderRadius,
    this.onTap,
    this.margin,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final Color? color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(AppRadius.lg);
    final decoration = BoxDecoration(
      color: gradient == null ? (color ?? AppColors.surface) : null,
      gradient: gradient,
      borderRadius: radius,
      border: border ??
          Border.all(
            color: AppColors.stroke.withValues(alpha: 0.6),
            width: 0.5,
          ),
    );

    final content = Padding(padding: padding, child: child);

    if (onTap == null) {
      return Container(
        margin: margin,
        decoration: decoration,
        child: content,
      );
    }

    return Container(
      margin: margin,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashColor: AppColors.accentGlow(0.08),
          highlightColor: AppColors.whiteOverlay(0.02),
          child: content,
        ),
      ),
    );
  }
}
