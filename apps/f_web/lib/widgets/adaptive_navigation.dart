import 'package:flutter/material.dart';

class AdaptiveNavigation extends StatelessWidget {
  const AdaptiveNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: const [],
      selectedIndex: 0,
    );
  }
}
