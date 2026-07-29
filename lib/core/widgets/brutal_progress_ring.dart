import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// The emotional centerpiece of the home screen.
///
/// A cinematic circular ring that breathes subtly, fills smoothly, and
/// emits a soft glow proportional to the user's progress. Designed to feel
/// rewarding without being aggressive.
class BrutalProgressRing extends StatelessWidget {
  const BrutalProgressRing({
    super.key,
    required this.progress,
    required this.disciplineScore,
    this.size = 240,
    this.strokeWidth = 14,
    this.accent = AppColors.accent,
    this.label = 'Discipline',
  });

  /// 0.0 → 1.0.
  final double progress;

  /// Score out of 100.
  final int disciplineScore;

  final double size;
  final double strokeWidth;
  final Color accent;
  final String label;

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    final glow = 0.20 + clamped * 0.35;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ambient breathing glow (very subtle).
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: glow * 0.18),
                  blurRadius: 60,
                  spreadRadius: 4,
                ),
              ],
            ),
          )
              .animate(
                onPlay: (c) => c.repeat(reverse: true),
              )
              .scaleXY(
                begin: 0.985,
                end: 1.015,
                duration: 4.seconds,
                curve: Curves.easeInOut,
              ),

          // The ring itself.
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: clamped),
            duration: const Duration(milliseconds: 1400),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return CustomPaint(
                size: Size.square(size),
                painter: _RingPainter(
                  progress: value,
                  strokeWidth: strokeWidth,
                  accent: accent,
                ),
              );
            },
          ),

          // Centerpiece text.
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$disciplineScore',
                style: AppTypography.ringNumber,
              ),
              const SizedBox(height: 4),
              Text(
                label.toUpperCase(),
                style: AppTypography.overline.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.accent,
  });

  final double progress;
  final double strokeWidth;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    // Track.
    final trackPaint = Paint()
      ..color = AppColors.surfaceElevated
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress arc with gradient.
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: -math.pi / 2,
      endAngle: math.pi * 1.5,
      colors: [
        accent.withValues(alpha: 0.55),
        accent,
        AppColors.accentSoft,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );

    // Tip dot — a small ember at the leading edge.
    final tipAngle = -math.pi / 2 + 2 * math.pi * progress;
    final tip = Offset(
      center.dx + radius * math.cos(tipAngle),
      center.dy + radius * math.sin(tipAngle),
    );
    final tipPaint = Paint()
      ..color = AppColors.accentSoft
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(tip, strokeWidth * 0.45, tipPaint);
    canvas.drawCircle(
      tip,
      strokeWidth * 0.28,
      Paint()..color = Colors.white.withValues(alpha: 0.95),
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.accent != accent ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
