import 'package:flutter/material.dart';

/// Brutal Mode color tokens.
///
/// Designed for "Calm Power" — matte black canvas, deeply muted surfaces,
/// burnt-orange accent reserved for moments that matter.
class AppColors {
  AppColors._();

  // ── Surfaces ───────────────────────────────────────────────────────
  static const Color background = Color(0xFF0B0B0B);
  static const Color backgroundSecondary = Color(0xFF121212);
  static const Color surface = Color(0xFF181818);
  static const Color surfaceElevated = Color(0xFF1E1E1E);
  static const Color divider = Color(0xFF262626);
  static const Color stroke = Color(0xFF2A2A2A);

  // ── Text ───────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF9A9A9A);
  static const Color textTertiary = Color(0xFF6B6B6B);
  static const Color textDisabled = Color(0xFF4A4A4A);

  // ── Brand ──────────────────────────────────────────────────────────
  static const Color accent = Color(0xFFFF6A00);        // Burnt orange
  static const Color accentSoft = Color(0xFFFFB547);    // Amber gold
  static const Color accentDeep = Color(0xFFCC5500);

  // ── Semantic ───────────────────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB020);
  static const Color error = Color(0xFFD64545);

  // ── Modes ──────────────────────────────────────────────────────────
  static const Color focus = Color(0xFF4D8DFF);
  static const Color recovery = Color(0xFF2DB6A3);

  // ── Gradients (subtle, premium) ────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFFFF6A00), Color(0xFFFFB547)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient focusGradient = LinearGradient(
    colors: [Color(0xFF4D8DFF), Color(0xFF2DB6A3)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A1A1A), Color(0xFF121212)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient ambientGradient = LinearGradient(
    colors: [Color(0xFF0B0B0B), Color(0xFF131313), Color(0xFF0B0B0B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5, 1.0],
  );

  // ── Alpha helpers ──────────────────────────────────────────────────
  static Color accentGlow(double opacity) =>
      accent.withValues(alpha: opacity);
  static Color whiteOverlay(double opacity) =>
      const Color(0xFFFFFFFF).withValues(alpha: opacity);
  static Color blackOverlay(double opacity) =>
      const Color(0xFF000000).withValues(alpha: opacity);
}
