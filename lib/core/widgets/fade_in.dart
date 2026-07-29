import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Standard cinematic entrance — soft fade with a slight rise.
class FadeInUp extends StatelessWidget {
  const FadeInUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.offsetY = 16,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOutCubic)
        .moveY(
          begin: offsetY,
          end: 0,
          duration: duration,
          curve: Curves.easeOutCubic,
        );
  }
}
