import 'package:flutter/material.dart';
import 'package:sigma/widgets/corner_radius_transition.dart';

/// A Floating Action Button with better hero transition to a card or popup.
class FloatingActionButtonWithCornerHeroTransition extends StatelessWidget {
  const FloatingActionButtonWithCornerHeroTransition(
      {Key key,
      this.icon,
      this.color,
      this.size = 60,
      this.toHeroColor,
      this.heroTag,
      this.onPressed,
      this.toHeroCornerRadius = 0})
      : super(key: key);

  /// The icon shown at the center of the button.
  final IconData icon;

  /// The background color of the button.
  final Color color;

  /// The diameter of the button.
  final double size;

  /// The color of the widget that this button will transform to.
  final Color toHeroColor;

  /// The hero tag for the transition.
  final Object heroTag;

  /// Function to be called when the button is pressed.
  final Function onPressed;

  /// The corner radius of the widget that this button will transform into.
  final double toHeroCornerRadius;

  /// The default Material rectangular Arc Tween.
  static RectTween createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the button size
      child: ButtonTheme(
        minWidth: size,
        height: size,
        child: Hero(
          flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
            // For better detail during the hero transition
            return ButtonToCardTransition(
                startCornerRadius: 30,
                endCornerRadius: toHeroCornerRadius,
                sizeAnim: animation,
                startColor: color ?? Theme.of(fromContext).accentColor,
                endColor: toHeroColor ?? Theme.of(toContext).scaffoldBackgroundColor);
          },
          createRectTween: createRectTween,
          tag: heroTag ?? '',
          // The actual button
          child: RaisedButton(
            elevation: 8,
            highlightElevation: 16,
            color: color ?? Theme.of(context).accentColor,
            child: Icon(icon, color: Theme.of(context).iconTheme.color),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
