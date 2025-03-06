import 'package:flutter/material.dart';
import 'package:ui_components/radio/gp_ratio_theme_data.dart';

final class GPRadio<T> extends StatelessWidget {
  const GPRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  final bool toggleable;

  final Color? activeColor;
  final WidgetStateProperty<Color?>? fillColor;

  @override
  Widget build(BuildContext context) {
    final themeData = GPRadioThemeData.of(context);

    final activeColor = this.activeColor ?? themeData.activeColor;

    final fillColor = this.fillColor ?? themeData.fillColor;

    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor,
      fillColor: fillColor,
      toggleable: toggleable,
    );
  }
}
