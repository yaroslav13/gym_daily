import 'package:flutter/material.dart';
import 'package:ui_components/elevated_button/gp_elevated_button_theme_data.dart';
import 'package:ui_components/theme/colors/gp_theme_colors_extension.dart';

final class GPElevetedButton extends StatelessWidget {
  const GPElevetedButton({
    required this.onPressed,
    required this.child,
    this.foregroundColor,
    this.backgroundGradient,
    this.shape,
    super.key,
  });

  final Color? foregroundColor;
  final WidgetStateProperty<LinearGradient?>? backgroundGradient;

  final OutlinedBorder? shape;

  final VoidCallback? onPressed;
  final Widget child;

  ButtonStyle _resolveButtonStyle(BuildContext context) {
    final themeData = GPElevatedButtonThemeData.of(context);

    final foregroundColor = this.foregroundColor ?? themeData.foregroundColor;

    final shape = this.shape ?? themeData.shape;

    return ElevatedButton.styleFrom(
      backgroundBuilder: (_, states, child) => _BackgroundGradient(
        states: states,
        backgroundGradient: backgroundGradient,
        child: child,
      ),
      shape: shape,
      foregroundColor: foregroundColor,
      disabledForegroundColor: foregroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: _resolveButtonStyle(context),
      onPressed: onPressed,
      child: child,
    );
  }
}

final class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient({
    required this.states,
    required this.child,
    this.backgroundGradient,
  });

  final WidgetStateProperty<LinearGradient?>? backgroundGradient;
  final Set<WidgetState> states;

  final Widget? child;

  LinearGradient _resolveGradient(BuildContext context) {
    final themeData = GPElevatedButtonThemeData.of(context);
    final themeColors = context.themeColors;

    final backgroundGradient =
        this.backgroundGradient ?? themeData.backgroundGradient;

    final resolvedBackgroundGradient = backgroundGradient?.resolve(states);

    if (resolvedBackgroundGradient != null) {
      return resolvedBackgroundGradient;
    }

    final backgroundColor = states.contains(WidgetState.disabled)
        ? themeColors.onSurfaceVariant
        : themeColors.brand;

    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        backgroundColor.withValues(alpha: 0.7),
        backgroundColor,
      ],
      stops: const [0.2, 1.0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        gradient: _resolveGradient(context),
      ),
      child: child,
    );
  }
}
