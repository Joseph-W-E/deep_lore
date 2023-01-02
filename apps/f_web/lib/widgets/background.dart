import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Image(
              'assets/be_a_man_unarmored.png',
              alignment: Alignment.centerRight,
              aspectRatio: 1800 / 3750,
              width: width,
              height: height,
            ),
            const Spacer(),
            _Image(
              'assets/be_a_man_armored.png',
              alignment: Alignment.centerLeft,
              aspectRatio: 1600 / 4000,
              width: width,
              height: height,
            ),
          ],
        );
      },
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(
    this.asset, {
    required this.alignment,
    required this.aspectRatio,
    required this.width,
    required this.height,
  });

  final String asset;
  final Alignment alignment;
  final double aspectRatio, width, height;

  @override
  Widget build(BuildContext context) {
    final size = Size(width, height);

    return Opacity(
      opacity: 0.2,
      child: Image.asset(
        asset,
        height: size.height,
        width: min(size.height * aspectRatio, size.width / 2),
        fit: BoxFit.fitHeight,
        alignment: alignment,
      ),
    );
  }
}
