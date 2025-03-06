import 'package:flutter/material.dart';
import 'package:ui_components/theme/colors/gp_colors.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

/// [GPThemeColors] is an [ThemeExtension] that provides GP colors.
@immutable
final class GPThemeColors extends ThemeExtension<GPThemeColors> {
  /// Creates a [GPThemeColors] from the given [GPColors].
  GPThemeColors.fromColors(GPColors colors)
      : this._(
          brand: colors.brand,
          onBrand: colors.onBrand,
          accent: colors.accent,
          onAccent: colors.onAccent,
          supportive: colors.supportive,
          surface: colors.surface,
          onSurface: colors.onSurface,
          onSurfaceVariant: colors.onSurfaceVariant,
          error: colors.error,
        );

  /// Use [GPColors.light] for [GPThemeColors] creation.
  factory GPThemeColors.light() {
    return GPThemeColors.fromColors(GPColors.light);
  }

  factory GPThemeColors.of(BuildContext context) {
    return context.themeExtension<GPThemeColors>() ?? GPThemeColors.light();
  }

  const GPThemeColors._({
    required this.brand,
    required this.onBrand,
    required this.accent,
    required this.onAccent,
    required this.supportive,
    required this.surface,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.error,
  });

  final Color brand;
  final Color onBrand;

  final Color accent;
  final Color onAccent;

  final Color supportive;

  final Color surface;
  final Color onSurface;
  final Color onSurfaceVariant;

  final Color error;

  @override
  GPThemeColors copyWith({
    Color? brand,
    Color? onBrand,
    Color? accent,
    Color? onAccent,
    Color? supportive,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? error,
  }) {
    return GPThemeColors._(
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      supportive: supportive ?? this.supportive,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<GPThemeColors> lerp(
    covariant ThemeExtension<GPThemeColors>? other,
    double t,
  ) {
    if (other is! GPThemeColors) {
      return this;
    }

    return GPThemeColors._(
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      supportive: Color.lerp(supportive, other.supportive, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
