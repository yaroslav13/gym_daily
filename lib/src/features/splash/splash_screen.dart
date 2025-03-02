import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_daily/src/resources/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ui_components/constants/gp_spacings.dart';

/// The [SplashScreen] is initial screen of app.
final class SplashScreen extends HookConsumerWidget {
  /// Creates an instance of [SplashScreen]
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const _GradientBackground(),
          Center(
            child: Column(
              spacing: GPSpacings.large,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.images.logo),
                SvgPicture.asset(Assets.images.pilot),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  void _configureSampler(FragmentShader shader, Size size, Canvas canvas) {
    shader.setFloatUniforms((uniforms) {
      uniforms.setSize(size);
    });

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: Assets.shaders.gradientBackground,
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) => _configureSampler(shader, size, canvas),
          child: child!,
        );
      },
      child: const SizedBox.expand(),
    );
  }
}
