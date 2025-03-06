import 'package:flutter/material.dart';
import 'package:ui_components/theme/typography/gp_theme_text_styles.dart';

extension GPThemeTextStylesX on BuildContext {
  GPThemeTextStyles get themeTextStyles => GPThemeTextStyles.of(this);
}
