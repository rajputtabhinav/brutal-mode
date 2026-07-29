import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

/// A subtle ambient backdrop that breathes — used behind the home screen
/// and other emotional moments. Movement is barely perceptible.
class BreathingBackground extends StatelessWidget {
  const BreathingBackground({
    super.key,
    required this.child,
    this.gradient,
    this.glowColor,
  });

  final Widget child;
  final Gradient? gradient;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final glow = glowColor ?? AppColors.accent;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.ambientGradient,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: IgnorePointer(
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      glow.withValues(alpha: 0.10),
                      glow.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(
                    begin: 0.85,
                    end: 1.0,
                    duration: 7.seconds,
                    curve: Curves.easeInOut,
                  ),
            ),
          ),
          Positioned(
            bottom: -160,
            left: -100,
            child: IgnorePointer(
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      glow.withValues(alpha: 0.06),
                      glow.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              )
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(
                    begin: 1.0,
                    end: 1.1,
                    duration: 9.seconds,
                    curve: Curves.easeInOut,
                  ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
