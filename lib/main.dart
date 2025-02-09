import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_daily/src/config/firebase/firebase_options.dart';
import 'package:gym_daily/src/gym_daily_app.dart';
import 'package:gym_daily/src/resources/translations.g.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  await Firebase.initializeApp(
    options: FlavoredFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: TranslationProvider(
        child: const ToastificationWrapper(
          child: GymDailyApp(),
        ),
      ),
    ),
  );
}
