import 'package:flutter/material.dart';
import 'package:ui_components/checkbox/gp_checkbox_theme_data.dart';

final class GPCheckbox extends StatelessWidget {
  const GPCheckbox({
    required this.value,
    required this.onChanged,
    this.isError = false,
    this.activeColor,
    this.checkColor,
    this.fillColor,
    this.shape,
    this.side,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  final Color? activeColor;
  final Color? checkColor;
  final WidgetStateProperty<Color?>? fillColor;

  final OutlinedBorder? shape;
  final BorderSide? side;

  final bool isError;

  @override
  Widget build(BuildContext context) {
    final themeData = GPCheckboxThemeData.of(context);

    final activeColor = this.activeColor ?? themeData.activeColor;
    final checkColor = this.checkColor ?? themeData.checkColor;

    final fillColor = this.fillColor ?? themeData.fillColor;

    final shape = this.shape ?? themeData.shape;

    final side = this.side ?? themeData.side;

    return Checkbox(
      activeColor: activeColor,
      checkColor: checkColor,
      fillColor: fillColor,
      shape: shape,
      side: side,
      isError: isError,
      value: value,
      onChanged: (value) => onChanged?.call(value ?? false),
    );
  }
}
