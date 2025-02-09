import 'package:gym_daily/src/config/build_config/flavor_type.dart';

final class BuildConfig {
  const BuildConfig._({
    required this.flavor,
  });

  factory BuildConfig.fromEnvironment() {
    return BuildConfig._(
      flavor: FlavorType.fromEnvironment,
    );
  }

  final FlavorType flavor;

  bool get isDev => flavor == FlavorType.dev;

  bool get isProd => flavor == FlavorType.prod;
}
