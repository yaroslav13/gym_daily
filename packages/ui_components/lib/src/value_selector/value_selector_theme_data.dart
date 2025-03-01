import 'package:flutter/material.dart';

final class ValueSelectorThemeData
    extends ThemeExtension<ValueSelectorThemeData> {
  const ValueSelectorThemeData({
    this.slideSurfaceColor,
    this.selectorBackgroundColor,
    this.selectorBackgroundGradient,
    this.slideSurfaceGradient,
    this.slideSurfaceBoxShadow,
    this.selectorBoxShadow,
  });

  factory ValueSelectorThemeData._defaultThemeData(BuildContext context) =>
      ValueSelectorThemeData(
        slideSurfaceGradient: RadialGradient(
          colors: [
            Theme.of(context)
                .colorScheme
                .primary,
            Theme.of(context)
                .colorScheme
                .onPrimary,
          ],
          stops: const [0.85, 1.0],
        ),
        slideSurfaceBoxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .surface
                .withAlpha((255.0 * 0.5).round()),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(-3, -3),
          ),
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withAlpha((255.0 * 0.5).round()),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(3, 3),
          ),
        ],
        selectorBackgroundColor: Theme.of(context).colorScheme.primary,
        selectorBoxShadow: [
          BoxShadow(
            color: Colors.blue.withAlpha(
              (255.0 * 0.5).round(),
            ),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      );

  final Color? slideSurfaceColor;
  final Gradient? slideSurfaceGradient;
  final List<BoxShadow>? slideSurfaceBoxShadow;

  final Color? selectorBackgroundColor;
  final Gradient? selectorBackgroundGradient;
  final List<BoxShadow>? selectorBoxShadow;

  static ValueSelectorThemeData of(BuildContext context) {
    return Theme.of(context).extension<ValueSelectorThemeData>() ??
        ValueSelectorThemeData._defaultThemeData(context);
  }

  @override
  ThemeExtension<ValueSelectorThemeData> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<ValueSelectorThemeData> lerp(
    covariant ThemeExtension<ValueSelectorThemeData>? other,
    double t,
  ) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}
