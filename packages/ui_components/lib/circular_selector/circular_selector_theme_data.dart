import 'package:flutter/material.dart';
import 'package:ui_components/theme/typography/gp_theme_text_styles_extension.dart';

const _defaultDimension = 300.0;
const _defaultProgressStrokeWidth = 30.0;

final class CircularSelectorThemeData
    extends ThemeExtension<CircularSelectorThemeData> {
  const CircularSelectorThemeData({
    this.slideSurfaceColor,
    this.slideSurfaceGradient,
    this.slideSurfaceBoxShadow,
    this.controlBackgroundColor,
    this.controlBackgroundGradient,
    this.controlBoxShadow,
    this.controlBorder,
    this.centerBackgroundColor,
    this.centerBackgroundGradient,
    this.centerBoxShadow,
    this.controlForegroundColor,
    this.controlForegroundGradient,
    this.progressStrokeWidth = _defaultProgressStrokeWidth,
    this.progressGradientFactory,
    this.dimension = _defaultDimension,
    this.valueBuilderTextStyle,
  });

  factory CircularSelectorThemeData.darkThemeData(BuildContext context) =>
      CircularSelectorThemeData.lightThemeData(context).copyWith(
        controlForegroundGradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: const [0.3, 5.0],
          colors: [
            Color(0xFFFF8F00),
            Color(0xFF00C853),
          ],
        ),
        progressGradientFactory: (start, end) => SweepGradient(
          startAngle: start,
          endAngle: end,
          colors: [
            Color(0xFFFF8F00),
            Color(0xFF00C853),
          ],
          stops: const [0.5, 5.0],
          transform: GradientRotation(start),
        ),
      );

  factory CircularSelectorThemeData.lightThemeData(BuildContext context) {
    final themeTextStyles = context.themeTextStyles;
    //final themeTextStyles =  Theme.of(context).textTheme;

    final valueBuilderTextStyle = themeTextStyles.headlineLarge;
    return CircularSelectorThemeData(
      slideSurfaceBoxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((255.0 * 0.8).round()),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(-3, -3),
        ),
        BoxShadow(
          color: Colors.white.withAlpha((255.0 * 0.8).round()),
          blurRadius: 10,
          spreadRadius: 1,
          offset: const Offset(3, 3),
        ),
      ],
      controlBackgroundColor: Color(0xFFE9E9E9),
      controlForegroundColor: Theme.of(context).colorScheme.primary,
      controlForegroundGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.3, 5.0],
        colors: [
          Color(0xFF0000FF),
          Color(0xFF000099),
        ],
      ),
      centerBackgroundGradient: LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Color(0xFFDBCECE),
          Color(0xFFEFEFEF),
        ],
      ),
      centerBoxShadow: [
        BoxShadow(
          offset: Offset(14, 14),
          color: Color(0x73404040),
          blurRadius: 28,
        ),
      ],
      controlBorder: Border.all(
        color: Theme.of(context).colorScheme.surface,
        width: 0.5,
      ),
      controlBoxShadow: [
        BoxShadow(
          color: Color(0x73404040),
          blurRadius: 5,
        ),
      ],
      progressGradientFactory: (start, end) => SweepGradient(
        startAngle: start,
        endAngle: end,
        stops: const [0.5, 5.0],
        colors: [
          Color(0xFF00C853),
          Color(0xFF0000FF),
        ],
        transform: GradientRotation(
          start,
        ),
      ),
      valueBuilderTextStyle: valueBuilderTextStyle,
    );
  }

  final Color? slideSurfaceColor;
  final Gradient? slideSurfaceGradient;
  final List<BoxShadow>? slideSurfaceBoxShadow;
  final Gradient Function(double, double)? progressGradientFactory;

  final Color? controlBackgroundColor;
  final Border? controlBorder;
  final List<BoxShadow>? controlBoxShadow;
  final Color? controlForegroundColor;
  final Gradient? controlForegroundGradient;
  final Gradient? controlBackgroundGradient;
  final Color? centerBackgroundColor;
  final Gradient? centerBackgroundGradient;
  final List<BoxShadow>? centerBoxShadow;
  final double dimension;
  final TextStyle? valueBuilderTextStyle;
  final double progressStrokeWidth;

  double get slideZoneDimension => dimension * 0.3;

  double get controlDimension => slideZoneDimension * 0.4;

  double get valueZoneDimension => dimension - slideZoneDimension;

  static CircularSelectorThemeData of(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Theme.of(context).extension<CircularSelectorThemeData>() ??
        (brightness == Brightness.light
            ? CircularSelectorThemeData.lightThemeData(context)
            : CircularSelectorThemeData.darkThemeData(context));
  }

  @override
  CircularSelectorThemeData copyWith({
    Color? slideSurfaceColor,
    Gradient? slideSurfaceGradient,
    Color? controlBackgroundColor,
    Gradient? controlBackgroundGradient,
    List<BoxShadow>? slideSurfaceBoxShadow,
    List<BoxShadow>? controlBoxShadow,
    Border? controlBorder,
    Color? centerBackgroundColor,
    Gradient? centerBackgroundGradient,
    List<BoxShadow>? centerBoxShadow,
    Color? controlForegroundColor,
    Gradient? controlForegroundGradient,
    Gradient Function(double, double)? progressGradientFactory,
    double? dimension,
    double? progressStrokeWidth,
    TextStyle? valueBuilderTextStyle,
  }) {
    return CircularSelectorThemeData(
      slideSurfaceColor: slideSurfaceColor ?? this.slideSurfaceColor,
      slideSurfaceGradient: slideSurfaceGradient ?? this.slideSurfaceGradient,
      controlBackgroundColor:
          controlBackgroundColor ?? this.controlBackgroundColor,
      controlBackgroundGradient:
          controlBackgroundGradient ?? this.controlBackgroundGradient,
      slideSurfaceBoxShadow:
          slideSurfaceBoxShadow ?? this.slideSurfaceBoxShadow,
      controlBoxShadow: controlBoxShadow ?? this.controlBoxShadow,
      controlBorder: controlBorder ?? this.controlBorder,
      centerBackgroundColor:
          centerBackgroundColor ?? this.centerBackgroundColor,
      centerBackgroundGradient:
          centerBackgroundGradient ?? this.centerBackgroundGradient,
      centerBoxShadow: centerBoxShadow ?? this.centerBoxShadow,
      controlForegroundColor:
          controlForegroundColor ?? this.controlForegroundColor,
      controlForegroundGradient:
          controlForegroundGradient ?? this.controlForegroundGradient,
      progressGradientFactory:
          progressGradientFactory ?? this.progressGradientFactory,
      dimension: dimension ?? this.dimension,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
      valueBuilderTextStyle:
          valueBuilderTextStyle ?? this.valueBuilderTextStyle,
    );
  }

  @override
  ThemeExtension<CircularSelectorThemeData> lerp(
    covariant ThemeExtension<CircularSelectorThemeData>? other,
    double t,
  ) {
    if (other is! CircularSelectorThemeData) {
      return this;
    }

    // Helper function to lerp nullable values
    T? lerpNullable<T>(T? a, T? b, double t) {
      if (a == null && b == null) return null;
      if (a == null) return b;
      if (b == null) return a;

      if (a is Color && b is Color) return Color.lerp(a, b, t) as T;
      if (a is Gradient && b is Gradient) {
        return b;
      }
      if (a is List<BoxShadow> && b is List<BoxShadow>) {
        return List.generate(
          a.length,
          (index) => BoxShadow.lerp(
            a[index],
            b[index],
            t,
          ),
        ) as T;
      }

      return a;
    }

    return CircularSelectorThemeData(
      slideSurfaceColor: lerpNullable(
        slideSurfaceColor,
        other.slideSurfaceColor,
        t,
      ),
      slideSurfaceGradient: lerpNullable(
        slideSurfaceGradient,
        other.slideSurfaceGradient,
        t,
      ),
      controlBackgroundColor: lerpNullable(
        controlBackgroundColor,
        other.controlBackgroundColor,
        t,
      ),
      controlBackgroundGradient: lerpNullable(
        controlBackgroundGradient,
        other.controlBackgroundGradient,
        t,
      ),
      slideSurfaceBoxShadow: lerpNullable(
        slideSurfaceBoxShadow,
        other.slideSurfaceBoxShadow,
        t,
      ),
      controlBoxShadow: lerpNullable(
        controlBoxShadow,
        other.controlBoxShadow,
        t,
      ),
      controlBorder: lerpNullable(
        controlBorder,
        other.controlBorder,
        t,
      ),
      centerBackgroundColor: lerpNullable(
        centerBackgroundColor,
        other.centerBackgroundColor,
        t,
      ),
      centerBackgroundGradient: lerpNullable(
        centerBackgroundGradient,
        other.centerBackgroundGradient,
        t,
      ),
      centerBoxShadow: lerpNullable(
        centerBoxShadow,
        other.centerBoxShadow,
        t,
      ),
      controlForegroundColor: lerpNullable(
        controlForegroundColor,
        other.controlForegroundColor,
        t,
      ),
      controlForegroundGradient: lerpNullable(
        controlForegroundGradient,
        other.controlForegroundGradient,
        t,
      ),
      // For progress gradient factory, direct assignment might not make sense
      progressGradientFactory:
          t < 0.5 ? progressGradientFactory : other.progressGradientFactory,
    );
  }
}
