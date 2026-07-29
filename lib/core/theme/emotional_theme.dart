import 'package:flutter/material.dart';
import 'app_colors.dart';

/// The emotional state of the user — drives subtle UI adaptation.
///
/// The adaptation is intentionally subtle: a slight shift in accent gradient
/// and ambient tint. Never aggressive, never gimmicky.
enum EmotionalState {
  /// Default — clean, neutral, ready.
  neutral,

  /// Slightly cooler tones, softer contrast, more breathing space.
  stressed,

  /// Slightly sharper contrast, stronger accent — momentum.
  productive,

  /// Warm calming teal, low intensity, healing.
  recovering,
}

/// Resolved tokens for the current emotional state.
class EmotionalTheme {
  const EmotionalTheme({
    required this.state,
    required this.accent,
    required this.ambientGradient,
    required this.contrast,
  });

  final EmotionalState state;
  final Color accent;
  final LinearGradient ambientGradient;

  /// 0.0 (calm/low) → 1.0 (sharp/high). Multiplies certain stroke/shadow
  /// intensities to subtly tune the room.
  final double contrast;

  factory EmotionalTheme.from(EmotionalState state) {
    switch (state) {
      case EmotionalState.neutral:
        return const EmotionalTheme(
          state: EmotionalState.neutral,
          accent: AppColors.accent,
          ambientGradient: AppColors.ambientGradient,
          contrast: 0.65,
        );
      case EmotionalState.stressed:
        return EmotionalTheme(
          state: EmotionalState.stressed,
          accent: AppColors.focus,
          ambientGradient: LinearGradient(
            colors: [
              AppColors.background,
              const Color(0xFF0E1218),
              AppColors.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
          contrast: 0.45,
        );
      case EmotionalState.productive:
        return const EmotionalTheme(
          state: EmotionalState.productive,
          accent: AppColors.accent,
          ambientGradient: LinearGradient(
            colors: [
              AppColors.background,
              Color(0xFF161311),
              AppColors.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
          contrast: 0.85,
        );
      case EmotionalState.recovering:
        return EmotionalTheme(
          state: EmotionalState.recovering,
          accent: AppColors.recovery,
          ambientGradient: LinearGradient(
            colors: [
              AppColors.background,
              const Color(0xFF0E1614),
              AppColors.background,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 1.0],
          ),
          contrast: 0.40,
        );
    }
  }
}
