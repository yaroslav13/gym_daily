import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'assets/shaders/gradient_background6.frag',
          (context, shader, child) {
        return AnimatedSampler(
          shader: shader,
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class AnimatedSampler extends StatefulWidget {
  final FragmentShader shader;
  final Widget child;
  final AnimationController? animationController;

  const AnimatedSampler({
    Key? key,
    required this.shader,
    required this.child,
    this.animationController,
  }) : super(key: key);

  @override
  State<AnimatedSampler> createState() => _AnimatedSamplerState();
}

class _AnimatedSamplerState extends State<AnimatedSampler> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(vsync: this, duration: const Duration(seconds: 100))
          ..repeat();
  }

  @override
  void dispose() {
    if (widget.animationController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ShaderPainter(
            shader: widget.shader,
            time: _controller.value * 1000, // Преобразуем в миллисекунды
          ),
          child: widget.child,
        );
      },
    );
  }
}

class ShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  ShaderPainter({required this.shader, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}