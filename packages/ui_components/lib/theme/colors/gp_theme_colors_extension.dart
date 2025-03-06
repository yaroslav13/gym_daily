import 'package:flutter/material.dart';
import 'package:ui_components/theme/colors/gp_theme_colors.dart';

extension GPThemeColorsX on BuildContext {
  GPThemeColors get themeColors => GPThemeColors.of(this);
}
