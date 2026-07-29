import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography — premium, authoritative, calm.
/// Inter is used via google_fonts as a reliable stand-in for SF Pro /
/// General Sans / Satoshi when local font files are absent.
class AppTypography {
  AppTypography._();

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    double? height,
    double? letterSpacing,
    Color color = AppColors.textPrimary,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  // ── Display ────────────────────────────────────────────────────────
  // Used sparingly — onboarding, welcome moments, hero numbers.
  static TextStyle get displayLarge => _base(
        size: 56,
        weight: FontWeight.w800,
        height: 1.05,
        letterSpacing: -1.5,
      );

  static TextStyle get displayMedium => _base(
        size: 42,
        weight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -1.0,
      );

  // ── Headlines ──────────────────────────────────────────────────────
  static TextStyle get headlineLarge => _base(
        size: 30,
        weight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.6,
      );

  static TextStyle get headlineMedium => _base(
        size: 24,
        weight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.4,
      );

  static TextStyle get headlineSmall => _base(
        size: 20,
        weight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.2,
      );

  // ── Body ───────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => _base(
        size: 17,
        weight: FontWeight.w500,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _base(
        size: 15,
        weight: FontWeight.w400,
        height: 1.55,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => _base(
        size: 13,
        weight: FontWeight.w400,
        height: 1.5,
        color: AppColors.textSecondary,
      );

  // ── Labels / micro ─────────────────────────────────────────────────
  static TextStyle get labelLarge => _base(
        size: 14,
        weight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMedium => _base(
        size: 12,
        weight: FontWeight.w500,
        letterSpacing: 0.4,
        color: AppColors.textSecondary,
      );

  static TextStyle get overline => _base(
        size: 11,
        weight: FontWeight.w600,
        letterSpacing: 1.6,
        color: AppColors.textSecondary,
      );

  // ── Special: ring number ───────────────────────────────────────────
  static TextStyle get ringNumber => _base(
        size: 64,
        weight: FontWeight.w800,
        height: 1,
        letterSpacing: -2.5,
      );
}
