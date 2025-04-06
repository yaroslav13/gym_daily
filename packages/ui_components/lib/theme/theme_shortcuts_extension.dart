import 'package:flutter/material.dart';

extension ThemeShortcutsX on BuildContext {
  ThemeData get theme => Theme.of(this);

  T? themeExtension<T>() => theme.extension<T>();

  ColorScheme get materialColorScheme => theme.colorScheme;

  TextTheme get materialTextTheme => TextTheme.of(this);
}
