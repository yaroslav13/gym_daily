import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

@immutable
final class GPRadioThemeData extends ThemeExtension<GPRadioThemeData> {
  const GPRadioThemeData({
    this.activeColor,
    this.fillColor,
  });

  factory GPRadioThemeData.of(BuildContext context) {
    return context.themeExtension<GPRadioThemeData>() ??
        const GPRadioThemeData();
  }

  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;

  @override
  GPRadioThemeData copyWith({
    Color? activeColor,
    WidgetStateProperty<Color?>? fillColor,
  }) {
    return GPRadioThemeData(
      activeColor: activeColor ?? this.activeColor,
      fillColor: fillColor ?? this.fillColor,
    );
  }

  @override
  ThemeExtension<GPRadioThemeData> lerp(
    covariant ThemeExtension<GPRadioThemeData>? other,
    double t,
  ) {
    if (other is! GPRadioThemeData) {
      return this;
    }

    return GPRadioThemeData(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      fillColor: WidgetStateProperty.lerp<Color?>(
        fillColor,
        other.fillColor,
        t,
        Color.lerp,
      ),
    );
  }
}
