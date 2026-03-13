import 'package:flutter/material.dart';

class SeparatingLine extends StatelessWidget {
  const SeparatingLine({
    super.key,
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [colors.onPrimary, colors.onSecondary.withAlpha(80), colors.onPrimary],
          stops: [0.1, 0.5, 0.9],
        ),
      ),
    );
  }
}
