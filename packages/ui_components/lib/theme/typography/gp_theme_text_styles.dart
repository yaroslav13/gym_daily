import 'package:flutter/material.dart';
import 'package:ui_components/theme/theme_shortcuts_extension.dart';
import 'package:ui_components/theme/typography/gp_fonts.dart';

final class GPThemeTextStyles extends ThemeExtension<GPThemeTextStyles> {
  factory GPThemeTextStyles.fromTextTheme(TextTheme textTheme) {
    return GPThemeTextStyles._(
      headerLarge: textTheme.displayLarge ??
          GPFonts.regular(textStyle: textTheme.displayLarge),
      headerMedium: textTheme.displayMedium ??
          GPFonts.regular(textStyle: textTheme.displayMedium),
      headerSmall: textTheme.displaySmall ??
          GPFonts.regular(textStyle: textTheme.displaySmall),
      titleLarge: textTheme.headlineMedium ??
          GPFonts.regular(textStyle: textTheme.headlineMedium),
      titleMedium: textTheme.headlineSmall ??
          GPFonts.regular(textStyle: textTheme.headlineSmall),
      subtitle: textTheme.titleMedium ??
          GPFonts.regular(textStyle: textTheme.titleMedium),
      bodyLarge: textTheme.bodyLarge ??
          GPFonts.regular(textStyle: textTheme.bodyLarge),
      bodyMedium: textTheme.bodyMedium ??
          GPFonts.regular(textStyle: textTheme.bodyMedium),
      bodySmall: textTheme.bodySmall ??
          GPFonts.regular(textStyle: textTheme.bodySmall),
      caption: textTheme.labelSmall ??
          GPFonts.regular(textStyle: textTheme.labelSmall),
      button: textTheme.labelLarge ??
          GPFonts.regular(textStyle: textTheme.labelLarge),
    );
  }

  factory GPThemeTextStyles.of(BuildContext context) {
    final textTheme = context.materialTextTheme;
    final extension = context.themeExtension<GPThemeTextStyles>();
    if (extension != null) {
      return extension;
    }
    return GPThemeTextStyles.fromTextTheme(textTheme);
  }

  const GPThemeTextStyles._({
    required this.headerLarge,
    required this.headerMedium,
    required this.headerSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.subtitle,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.caption,
    required this.button,
  });

  final TextStyle headerLarge;
  final TextStyle headerMedium;
  final TextStyle headerSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle subtitle;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle caption;
  final TextStyle button;

  @override
  ThemeExtension<GPThemeTextStyles> copyWith({
    TextStyle? headerLarge,
    TextStyle? headerMedium,
    TextStyle? headerSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? subtitle,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? caption,
    TextStyle? button,
  }) {
    return GPThemeTextStyles._(
      headerLarge: headerLarge ?? this.headerLarge,
      headerMedium: headerMedium ?? this.headerMedium,
      headerSmall: headerSmall ?? this.headerSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      subtitle: subtitle ?? this.subtitle,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      caption: caption ?? this.caption,
      button: button ?? this.button,
    );
  }

  @override
  ThemeExtension<GPThemeTextStyles> lerp(
    covariant ThemeExtension<GPThemeTextStyles>? other,
    double t,
  ) {
    if (other is! GPThemeTextStyles) {
      return this;
    }

    return GPThemeTextStyles._(
      headerLarge: TextStyle.lerp(headerLarge, other.headerLarge, t)!,
      headerMedium: TextStyle.lerp(headerMedium, other.headerMedium, t)!,
      headerSmall: TextStyle.lerp(headerSmall, other.headerSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      button: TextStyle.lerp(button, other.button, t)!,
    );
  }
}
