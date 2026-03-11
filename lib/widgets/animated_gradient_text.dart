import 'package:flutter/material.dart';
import 'package:portfolio_web/theme/app_theme.dart';

class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                AppTheme.accentPrimary,
                AppTheme.accentSecondary,
                Color(0xFFec4899),
                AppTheme.accentPrimary,
              ],
              stops: const [0.0, 0.33, 0.66, 1.0],
              begin: Alignment(-1.0 + _controller.value * 3, 0),
              end: Alignment(1.0 + _controller.value * 3, 0),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: widget.style?.copyWith(color: Colors.white) ??
                const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
