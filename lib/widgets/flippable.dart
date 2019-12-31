import 'dart:math' as Math;
import 'package:flutter/material.dart';

class FlippableController {
  Function(bool) handleFlip;
  void flipFront() => handleFlip(false);
  void flipBack() => handleFlip(true);
}

/// A flippable, animated popup that can smoothly transition between multiple pages.
class Flippable extends StatefulWidget {
  Flippable(
      {Key key,
      this.frontChildren,
      this.backChildren,
      this.controller,
      this.heroTag,
      this.heroRectTween,
      this.initialTransformMatrix})
      : super(key: key);

  final List<Widget> frontChildren;
  final List<Widget> backChildren;
  final FlippableController controller;
  final Object heroTag;
  final Tween<Rect> Function(Rect, Rect) heroRectTween;
  final Matrix4 initialTransformMatrix;
  // TODO: Add width and parameters

  @override
  _FlippableState createState() => _FlippableState();
}

class _FlippableState extends State<Flippable> with TickerProviderStateMixin {
  AnimationController rotationController;
  Animation<double> rotationAnimation;

  bool halfFlipped = false;

  @override
  void initState() {
    super.initState();

    // Initialize rotation animation
    rotationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    Animation rotationCurve =
        CurvedAnimation(curve: Curves.easeInOut, parent: rotationController);
    rotationAnimation = Tween(begin: 0.0, end: Math.pi).animate(rotationCurve)
      ..addListener(() {
        setState(() {
          halfFlipped = rotationController.value >= 0.5;
        });
      });

    // Handle controller callbacks
    widget.controller.handleFlip = (isBack) {
      isBack ? rotationController.forward() : rotationController.reverse();
    };
  }

  // TODO: Set transform matrix to default if null.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black.withOpacity(0.55),
          child: Center(
            child: Hero(
              //createRectTween: FloatingActionButtonWithCornerHeroTransition.createRectTween,
              tag: 'fab',
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0009)
                  // Correct behavior with different screen sizes
                  // TODO: Add center rotation mode
                  ..translate((MediaQuery.of(context).size.width - 80) *
                      (rotationAnimation.value / Math.pi))
                  ..rotateY(rotationAnimation.value),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  type: MaterialType.card,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                        constraints: BoxConstraints(
                            maxWidth: (MediaQuery.of(context).size.width < 800)
                                ? MediaQuery.of(context).size.width - 80
                                : 720),
                        child: Transform(
                          alignment: FractionalOffset.center,
                          transform: Matrix4.identity()
                            ..rotateY(halfFlipped ? Math.pi : 0),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: halfFlipped
                                  ? widget.backChildren
                                  : widget.frontChildren),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
