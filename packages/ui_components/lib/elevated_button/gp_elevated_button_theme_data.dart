import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

@immutable
final class GPElevatedButtonThemeData
    extends ThemeExtension<GPElevatedButtonThemeData> {
  const GPElevatedButtonThemeData({
    this.foregroundColor,
    this.backgroundGradient,
    this.shape,
  });

  factory GPElevatedButtonThemeData.of(BuildContext context) {
    return context.themeExtension<GPElevatedButtonThemeData>() ??
        const GPElevatedButtonThemeData();
  }

  final Color? foregroundColor;
  final WidgetStateProperty<LinearGradient?>? backgroundGradient;
  final OutlinedBorder? shape;

  @override
  GPElevatedButtonThemeData copyWith({
    Color? foregroundColor,
    WidgetStateProperty<LinearGradient?>? backgroundGradient,
    OutlinedBorder? shape,
  }) {
    return GPElevatedButtonThemeData(
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      shape: shape ?? this.shape,
    );
  }

  @override
  ThemeExtension<GPElevatedButtonThemeData> lerp(
    covariant ThemeExtension<GPElevatedButtonThemeData>? other,
    double t,
  ) {
    if (other is! GPElevatedButtonThemeData) {
      return this;
    }

    return GPElevatedButtonThemeData(
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
      backgroundGradient: WidgetStateProperty.lerp<LinearGradient?>(
        backgroundGradient,
        other.backgroundGradient,
        t,
        LinearGradient.lerp,
      ),
      shape: OutlinedBorder.lerp(shape, other.shape, t),
    );
  }
}
