import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

@immutable
final class GPOutlinedButtonThemeData
    extends ThemeExtension<GPOutlinedButtonThemeData> {
  const GPOutlinedButtonThemeData({
    this.foregroundColor,
  });

  factory GPOutlinedButtonThemeData.of(BuildContext context) {
    return context.themeExtension<GPOutlinedButtonThemeData>() ??
        const GPOutlinedButtonThemeData();
  }

  final Color? foregroundColor;

  @override
  GPOutlinedButtonThemeData copyWith({
    Color? foregroundColor,
  }) {
    return GPOutlinedButtonThemeData(
      foregroundColor: foregroundColor ?? this.foregroundColor,
    );
  }

  @override
  ThemeExtension<GPOutlinedButtonThemeData> lerp(
    covariant ThemeExtension<GPOutlinedButtonThemeData>? other,
    double t,
  ) {
    if (other is! GPOutlinedButtonThemeData) {
      return this;
    }

    return GPOutlinedButtonThemeData(
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t),
    );
  }
}
