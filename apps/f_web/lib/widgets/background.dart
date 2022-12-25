import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _Image(
          'assets/be_a_man_unarmored.png',
          alignment: Alignment.centerRight,
          aspectRatio: 1800 / 3750,
        ),
        Spacer(),
        _Image(
          'assets/be_a_man_armored.png',
          alignment: Alignment.centerLeft,
          aspectRatio: 1600 / 4000,
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(
    this.asset, {
    required this.alignment,
    required this.aspectRatio,
  });

  final String asset;
  final Alignment alignment;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
