import 'package:flutter/cupertino.dart';
import 'package:ui_components/switcher/gp_switcher_theme_data.dart';
import 'package:ui_components/theme/colors/gp_theme_colors_extension.dart';

final class GPSwitcher extends StatelessWidget {
  const GPSwitcher({
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  final Color? activeTrackColor;
  final Color? inactiveTrackColor;

  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    final themeData = GPSwitcherThemeData.of(context);
    final themeColors = context.themeColors;

    final thumbColor =
        this.thumbColor ?? themeData.thumbColor ?? themeColors.surface;

    final activeTrackColor = this.activeTrackColor ??
        themeData.activeTrackColor ??
        themeColors.supportive;

    final inactiveTrackColor = this.inactiveTrackColor ??
        themeData.inactiveTrackColor ??
        themeColors.onSurfaceVariant;

    return CupertinoSwitch(
      thumbColor: thumbColor,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
      value: value,
      onChanged: onChanged,
    );
  }
}
