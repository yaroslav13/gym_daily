import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/theme/colors/gp_colors.dart';

/// A color scheme for the GymPilot theme.
extension type GPColorScheme._(ColorScheme _) implements ColorScheme {
  /// Creates a color scheme from the given [GPColors].
  factory GPColorScheme.fromColors(GPColors colors) {
    final colorScheme = _createColorScheme(colors);
    return GPColorScheme._(colorScheme);
  }

  static ColorScheme _createColorScheme(GPColors colors) {
    return SeedColorScheme.fromSeeds(
      primaryKey: colors.brand,
      onPrimary: colors.onBrand,
      secondaryKey: colors.accent,
      onSecondary: colors.onAccent,
      tertiaryKey: colors.supportive,
      errorKey: colors.error,
      neutralKey: colors.surface,
      onSurface: colors.onSurface,
      neutralVariantKey: colors.onSurfaceVariant,
      tones: FlexTones.vivid(Brightness.light),
    );
  }
}
