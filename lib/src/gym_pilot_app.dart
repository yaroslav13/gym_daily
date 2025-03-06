import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym_daily/src/providers/navigation/router_provider.dart';
import 'package:gym_daily/src/providers/theme/theme_provider.dart';
import 'package:gym_daily/src/resources/translations.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The [GymPilotApp] is root widget of app.
final class GymPilotApp extends HookConsumerWidget {
  /// Creates an instance of [GymPilotApp]
  const GymPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: theme,
      routerConfig: router,
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
    );
  }
}
