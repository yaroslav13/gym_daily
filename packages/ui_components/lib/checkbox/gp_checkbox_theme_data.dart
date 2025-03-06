import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';

@immutable
final class GPCheckboxThemeData extends ThemeExtension<GPCheckboxThemeData> {
  const GPCheckboxThemeData({
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.shape,
    this.side,
  });

  factory GPCheckboxThemeData.of(BuildContext context) {
    return context.themeExtension<GPCheckboxThemeData>() ??
        const GPCheckboxThemeData();
  }

  final Color? activeColor;
  final Color? checkColor;
  final WidgetStateProperty<Color?>? fillColor;

  final OutlinedBorder? shape;
  final BorderSide? side;

  @override
  GPCheckboxThemeData copyWith({
    Color? activeColor,
    Color? checkColor,
    WidgetStateProperty<Color?>? fillColor,
    OutlinedBorder? shape,
    BorderSide? side,
  }) {
    return GPCheckboxThemeData(
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      fillColor: fillColor ?? this.fillColor,
      shape: shape ?? this.shape,
      side: side ?? this.side,
    );
  }

  @override
  ThemeExtension<GPCheckboxThemeData> lerp(
    covariant ThemeExtension<GPCheckboxThemeData>? other,
    double t,
  ) {
    if (other is! GPCheckboxThemeData) {
      return this;
    }

    return GPCheckboxThemeData(
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      checkColor: Color.lerp(checkColor, other.checkColor, t),
      fillColor: WidgetStateProperty.lerp<Color?>(
        fillColor,
        other.fillColor,
        t,
        Color.lerp,
      ),
      shape: OutlinedBorder.lerp(shape, other.shape, t),
      side: _lerpSides(side, other.side, t),
    );
  }

  static BorderSide? _lerpSides(BorderSide? a, BorderSide? b, double t) {
    if (a == null || b == null) {
      return null;
    }

    if (identical(a, b)) {
      return a;
    }

    BorderSide? resolvedA;
    if (a is WidgetStateBorderSide) {
      resolvedA = a.resolve(<WidgetState>{});
    }

    BorderSide? resolvedB;
    if (b is WidgetStateBorderSide) {
      resolvedB = b.resolve(<WidgetState>{});
    }

    return BorderSide.lerp(resolvedA!, resolvedB!, t);
  }
}
