import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

@immutable
final class GPSwitcherThemeData extends ThemeExtension<GPSwitcherThemeData> {
  const GPSwitcherThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
  });

  factory GPSwitcherThemeData.of(BuildContext context) {
    return context.themeExtension<GPSwitcherThemeData>() ??
        const GPSwitcherThemeData();
  }

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;

  final Color? thumbColor;

  @override
  GPSwitcherThemeData copyWith({
    Color? activeTrackColor,
    Color? inactiveTrackColor,
    Color? thumbColor,
  }) {
    return GPSwitcherThemeData(
      activeTrackColor: activeTrackColor ?? this.activeTrackColor,
      inactiveTrackColor: inactiveTrackColor ?? this.inactiveTrackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }

  @override
  ThemeExtension<GPSwitcherThemeData> lerp(
    covariant ThemeExtension<GPSwitcherThemeData>? other,
    double t,
  ) {
    if (other is! GPSwitcherThemeData) {
      return this;
    }

    return GPSwitcherThemeData(
      activeTrackColor: Color.lerp(activeTrackColor, other.activeTrackColor, t),
      inactiveTrackColor:
          Color.lerp(inactiveTrackColor, other.inactiveTrackColor, t),
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
    );
  }
}
