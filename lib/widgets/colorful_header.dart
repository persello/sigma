import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

/// A colorful background with parallax animations.
class ColorfulHeader extends StatefulWidget {
  ColorfulHeader({
    Key key,
    this.child,
    this.firstColor = Colors.amberAccent,
    this.secondColor = Colors.red,
    this.enableParallax = true,
    this.backgroundParallaxIntensity = 1,
    this.foregroundParallaxIntensity = 1,
    this.maxGyroRate = 5,
    this.returnToHomeSpeed = 0.1,
    this.smoothingDuration,
    this.borderRadius,
    this.shadow,
  }) : super(key: key);

  final Widget child;
  final Color firstColor;
  final Color secondColor;
  final bool enableParallax;
  final double backgroundParallaxIntensity;
  final double foregroundParallaxIntensity;
  final double maxGyroRate;
  final double returnToHomeSpeed;
  final Duration smoothingDuration;
  final BorderRadius borderRadius;
  final List<BoxShadow> shadow;

  @override
  _ColorfulHeaderState createState() => _ColorfulHeaderState();
}

class _ColorfulHeaderState extends State<ColorfulHeader> {
  StreamSubscription<GyroscopeEvent> gyroStream;

  double gx = 0;
  double gy = 0;

  @override
  void initState() {
    if (widget.enableParallax)
      gyroStream = gyroscopeEvents.listen((GyroscopeEvent event) {
        setState(() {
          gx += event.y.abs() > widget.maxGyroRate ? (widget.maxGyroRate * event.y.sign) : event.y;
          gy += event.x.abs() > widget.maxGyroRate ? (widget.maxGyroRate * event.x.sign) : event.x;

          // Return to home
          gx -= gx * widget.returnToHomeSpeed;
          gy -= gy * widget.returnToHomeSpeed;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    gyroStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.returnToHomeSpeed <= 1,
        "Don't set RTH speeds greater than one. This will cause instabilities in the animation.");
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        boxShadow: widget.shadow ??
            [
              BoxShadow(
                color: Color.lerp(widget.secondColor, widget.firstColor, 0.75),
                blurRadius: 12,
                // Usually there is content below the header, so let's move the shadow up.
                offset: Offset(0, -2),
              )
            ],
        gradient: RadialGradient(
          colors: [widget.firstColor, widget.secondColor],
          radius: 4,
          center: Alignment.topLeft,
        ),
      ),
      child: ClipRect(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: widget.smoothingDuration ?? Duration(milliseconds: 200),
                height: 100,
                width: 100,
                transform: Matrix4.identity()
                  ..scale(6.00)
                  ..translate(-15.00 + gx * widget.backgroundParallaxIntensity,
                      -20.00 + gy * widget.backgroundParallaxIntensity),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: widget.firstColor.withOpacity(0.6),
                        blurRadius: 3,
                        offset: Offset(-24 + gx * widget.backgroundParallaxIntensity,
                            24 + gy * widget.backgroundParallaxIntensity))
                  ],
                  backgroundBlendMode: BlendMode.lighten,
                  borderRadius: BorderRadius.circular(50),
                  gradient: RadialGradient(
                    colors: [widget.firstColor.withAlpha(0), widget.firstColor.withOpacity(0.4)],
                    center: Alignment.center,
                    stops: [0.7, 1],
                    radius: 0.5,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              padding: EdgeInsets.symmetric(vertical: 20),
              duration: widget.smoothingDuration ?? Duration(milliseconds: 200),
              transform: Matrix4.identity()
                ..translate(gx * 1.5 * widget.foregroundParallaxIntensity,
                    gy * 1.5 * widget.foregroundParallaxIntensity),
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
