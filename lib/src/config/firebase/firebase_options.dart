import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:gym_daily/src/config/build_config/flavor_type.dart';
import 'package:gym_daily/src/config/firebase/firebase_options_dev.dart' as dev;
import 'package:gym_daily/src/config/firebase/firebase_options_prod.dart'
    as prod;

abstract final class FlavoredFirebaseOptions {
  const FlavoredFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    return switch (FlavorType.fromEnvironment) {
      FlavorType.prod => prod.DefaultFirebaseOptions.currentPlatform,
      FlavorType.dev => dev.DefaultFirebaseOptions.currentPlatform,
    };
  }
}
