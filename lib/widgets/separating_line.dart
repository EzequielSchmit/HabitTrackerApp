import 'package:flutter/material.dart';

class SeparatingLine extends StatelessWidget {
  const SeparatingLine({
    super.key,
    this.verticalMargin = 0,
    this.topMargin = 0,
    this.bottomMargin = 0,
  });

  final double verticalMargin, topMargin, bottomMargin;
  
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: verticalMargin > 0 ? EdgeInsets.symmetric(vertical: verticalMargin) : topMargin >= 0 && bottomMargin >= 0 ? EdgeInsets.only(top: topMargin, bottom: bottomMargin) : null,
      height: 0.7,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.transparent, colors.onSecondary.withAlpha(80), Colors.transparent],
          stops: [0.1, 0.5, 0.9],
        ),
      ),
    );
  }
}
