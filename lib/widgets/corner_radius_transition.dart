import 'package:flutter/material.dart';

class CornerRadiusTransition extends AnimatedWidget {
  final Animation<double> sizeAnim;
  final double startCornerRadius;
  final double endCornerRadius;
  final ClipRRect child;

  CornerRadiusTransition({
    this.sizeAnim,
    this.child,
    this.startCornerRadius,
    this.endCornerRadius,
  }) : super(listenable: sizeAnim);

  @override
  Widget build(BuildContext context) {
    final double delta = endCornerRadius - startCornerRadius;
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(startCornerRadius + delta * sizeAnim.value),
      child: child.child,
    ));
  }
}
