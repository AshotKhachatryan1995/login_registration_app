import 'package:flutter/material.dart';

class HorizontalPaddedWidget extends StatelessWidget {
  const HorizontalPaddedWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16), child: child);
  }
}
