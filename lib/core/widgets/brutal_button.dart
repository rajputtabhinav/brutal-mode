import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

enum BrutalButtonVariant { primary, ghost, outline }

/// A premium button with subtle press feedback and an optional leading icon.
class BrutalButton extends StatefulWidget {
  const BrutalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = BrutalButtonVariant.primary,
    this.icon,
    this.expanded = false,
    this.size = BrutalButtonSize.regular,
  });

  final String label;
  final VoidCallback? onPressed;
  final BrutalButtonVariant variant;
  final IconData? icon;
  final bool expanded;
  final BrutalButtonSize size;

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

enum BrutalButtonSize { small, regular, large }

class _BrutalButtonState extends State<BrutalButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onPressed == null;
    final isPrimary = widget.variant == BrutalButtonVariant.primary;
    final isOutline = widget.variant == BrutalButtonVariant.outline;

    final verticalPadding = switch (widget.size) {
      BrutalButtonSize.small => 10.0,
      BrutalButtonSize.regular => 16.0,
      BrutalButtonSize.large => 20.0,
    };
    final horizontalPadding = switch (widget.size) {
      BrutalButtonSize.small => 16.0,
      BrutalButtonSize.regular => 24.0,
      BrutalButtonSize.large => 28.0,
    };
    final textStyle = widget.size == BrutalButtonSize.small
        ? AppTypography.labelLarge
        : AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w600);

    final fg = isPrimary
        ? Colors.white
        : isDisabled
            ? AppColors.textDisabled
            : AppColors.textPrimary;

    final bg = isPrimary
        ? (isDisabled ? AppColors.surfaceElevated : null)
        : isOutline
            ? Colors.transparent
            : AppColors.surface;

    final gradient = isPrimary && !isDisabled
        ? AppColors.accentGradient
        : null;

    final border = isOutline
        ? Border.all(color: AppColors.divider, width: 1)
        : null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_pressed ? 0.985 : 1.0),
        width: widget.expanded ? double.infinity : null,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: bg,
          gradient: gradient,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: border,
          boxShadow: isPrimary && !isDisabled
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.30),
                    blurRadius: 24,
                    spreadRadius: -2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: widget.expanded ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, color: fg, size: 18),
              const SizedBox(width: AppSpacing.sm),
            ],
            Text(
              widget.label,
              style: textStyle.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
