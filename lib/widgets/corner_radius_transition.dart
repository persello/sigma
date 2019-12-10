import 'package:flutter/material.dart';

class ButtonToCardTransition extends AnimatedWidget {
  final Animation<double> sizeAnim;
  final double startCornerRadius;
  final double endCornerRadius;
  final Color startColor;
  final Color endColor;
  final Widget child;

  ButtonToCardTransition(
      {this.sizeAnim,
      this.child,
      this.startCornerRadius,
      this.endCornerRadius,
      this.startColor,
      this.endColor})
      : super(listenable: sizeAnim);

  @override
  Widget build(BuildContext context) {
    final double delta = endCornerRadius - startCornerRadius;
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(startCornerRadius + delta * sizeAnim.value),
        child: Container(
          child: child,
          color: Color.alphaBlend(endColor.withAlpha((sizeAnim.value * 255).toInt()), startColor),
        ),
      ),
    );
  }
}
