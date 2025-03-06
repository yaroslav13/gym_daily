import 'package:flutter/material.dart';
import 'package:ui_components/elevated_button/gp_elevated_button_theme_data.dart';
import 'package:ui_components/outlined_button/gp_outlined_button_theme_data.dart';
import 'package:ui_components/radio/gp_radio_fill_color_property.dart';
import 'package:ui_components/radio/gp_ratio_theme_data.dart';
import 'package:ui_components/switcher/gp_switcher_theme_data.dart';
import 'package:ui_components/theme/colors/gp_color_scheme.dart';
import 'package:ui_components/theme/colors/gp_colors.dart';
import 'package:ui_components/theme/colors/gp_theme_colors.dart';
import 'package:ui_components/theme/typography/gp_fonts.dart';
import 'package:ui_components/theme/typography/gp_theme_text_styles.dart';
import 'package:ui_components/theme/widget_state_properties/border_side_property.dart';
import 'package:ui_components/theme/widget_state_properties/gradient_property.dart';

final class GPTheme {
  const GPTheme.light() : this._(GPColors.light);

  const GPTheme._(this._colors);

  final GPColors _colors;

  ThemeData get data {
    final themeData = ThemeData.from(
      colorScheme: _colorScheme,
    );

    final textTheme = _applyFonts(themeData.textTheme);

    return themeData.copyWith(
      textTheme: textTheme,
      elevatedButtonTheme: _elevatedButtonThemeData,
      checkboxTheme: _checkboxThemeData,
      radioTheme: _radioThemeData,
      outlinedButtonTheme: _outlinedButtonThemeData,
      extensions: [
        // helpers
        GPThemeColors.fromColors(_colors),
        GPThemeTextStyles.fromTextTheme(textTheme),

        // theme configs
        _gpSwitcherThemeData,
        _gpRadioThemeData,
        _gpOutlinedButtonThemeData,
        _gpElevatedButtonThemeData,
      ],
    );
  }

  GPColorScheme get _colorScheme => GPColorScheme.fromColors(_colors);

  ElevatedButtonThemeData get _elevatedButtonThemeData {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: _elevatedButtonShape,
        foregroundColor: _colors.onBrand,
        disabledForegroundColor: _colors.onBrand,
      ),
    );
  }

  OutlinedButtonThemeData get _outlinedButtonThemeData {
    final enabledColor = _colors.brand;
    final disabledColor = _colors.onSurfaceVariant;

    return OutlinedButtonThemeData(
      style: ButtonStyle(
        side: BorderSideProperty(
          enabled: enabledColor,
          disabled: disabledColor,
          borderWidth: 1.5,
        ),
        foregroundColor:
            ButtonStyleButton.defaultColor(enabledColor, disabledColor),
      ),
    );
  }

  CheckboxThemeData get _checkboxThemeData {
    return CheckboxThemeData(
      side: BorderSide(
        color: _colors.onSurfaceVariant,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  RadioThemeData get _radioThemeData {
    return RadioThemeData(
      fillColor: GPRadioFillColorProperty(_colors),
    );
  }

  GPSwitcherThemeData get _gpSwitcherThemeData {
    return GPSwitcherThemeData(
      thumbColor: _colors.surface,
      activeTrackColor: _colors.supportive,
      inactiveTrackColor: _colors.onSurfaceVariant,
    );
  }

  GPRadioThemeData get _gpRadioThemeData {
    return GPRadioThemeData(
      fillColor: GPRadioFillColorProperty(_colors),
    );
  }

  GPElevatedButtonThemeData get _gpElevatedButtonThemeData {
    final enabledBackgroundColor = _colors.brand;
    final disabledBackgroundColor = _colors.onSurfaceVariant;

    return GPElevatedButtonThemeData(
      foregroundColor: _colors.onBrand,
      backgroundGradient: GradientProperty(
        enabledColors: [
          enabledBackgroundColor.withValues(alpha: 0.7),
          enabledBackgroundColor,
        ],
        disabledColors: [
          disabledBackgroundColor.withValues(alpha: 0.7),
          disabledBackgroundColor,
        ],
        stops: const [0.2, 1.0],
      ),
      shape: _elevatedButtonShape,
    );
  }

  GPOutlinedButtonThemeData get _gpOutlinedButtonThemeData {
    return GPOutlinedButtonThemeData(
      foregroundColor: _colors.brand,
    );
  }

  OutlinedBorder get _elevatedButtonShape {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    );
  }

  TextTheme _applyFonts(TextTheme textTheme) {
    const regular = GPFonts.regular;

    return TextTheme(
      displayLarge: regular(textStyle: textTheme.displayLarge),
      displayMedium: regular(textStyle: textTheme.displayMedium),
      displaySmall: regular(textStyle: textTheme.displaySmall),
      headlineLarge: regular(textStyle: textTheme.headlineLarge),
      headlineMedium: regular(textStyle: textTheme.headlineMedium),
      headlineSmall: regular(textStyle: textTheme.headlineSmall),
      titleLarge: regular(textStyle: textTheme.titleLarge),
      titleMedium: regular(textStyle: textTheme.titleMedium),
      titleSmall: regular(textStyle: textTheme.titleSmall),
      bodyLarge: regular(textStyle: textTheme.bodyLarge),
      bodyMedium: regular(textStyle: textTheme.bodyMedium),
      bodySmall: regular(textStyle: textTheme.bodySmall),
      labelLarge: regular(textStyle: textTheme.labelLarge),
      labelMedium: regular(textStyle: textTheme.labelMedium),
      labelSmall: regular(textStyle: textTheme.labelSmall),
    );
  }
}
