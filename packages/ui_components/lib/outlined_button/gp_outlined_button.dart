import 'package:flutter/material.dart';
import 'package:ui_components/outlined_button/gp_outlined_button_theme_data.dart';
import 'package:ui_components/theme/colors/gp_theme_colors_extension.dart';
import 'package:ui_components/theme/widget_state_properties/border_side_property.dart';

final class GPOutlinedButton extends StatelessWidget {
  const GPOutlinedButton({
    required this.child,
    this.onPressed,
    this.foregroundColor,
    super.key,
  });

  final Color? foregroundColor;

  final VoidCallback? onPressed;
  final Widget child;

  ButtonStyle _resolveButtonStyle(BuildContext context) {
    final themeData = GPOutlinedButtonThemeData.of(context);
    final themeColors = context.themeColors;

    final enabledColor = foregroundColor ?? themeData.foregroundColor;

    if (enabledColor == null) {
      return OutlinedButton.styleFrom();
    }

    final disabledColor = themeColors.onSurfaceVariant;

    return ButtonStyle(
      foregroundColor:
          ButtonStyleButton.defaultColor(enabledColor, disabledColor),
      side: BorderSideProperty(
        enabled: enabledColor,
        disabled: disabledColor,
        borderWidth: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: _resolveButtonStyle(context),
      onPressed: onPressed,
      child: child,
    );
  }
}
