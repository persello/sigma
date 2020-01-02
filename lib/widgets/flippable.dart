import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A controller for the [Flippable] widget.
class FlippableController {
  // Interface to widget
  Function(String) _handleNavigation;

  // Interface to user

  /// Navigates to a named page.
  void navigate(String pageName) => _handleNavigation(pageName);

  // Private variables (accessible by the widget)
  bool _isFlipped;
  String _currentRoute;

  // Getters

  /// Returns the current route name. This value is set only after a successful navigation.
  String get currentRouteName => _currentRoute;

  /// Returns [true] if the card is rotated for more than 90 degrees, [false] otherwise.
  bool get isFlipped => _isFlipped;
}

/// A flippable, animated popup that can smoothly transition between multiple pages.
class Flippable extends StatefulWidget {
  Flippable(
      {Key key,
      this.frontPages,
      this.backPages,
      this.firstPage,
      this.controller,
      this.heroTag,
      this.maxWidth = 320})
      : super(key: key);

  final Map<String, WidgetBuilder> frontPages;
  final Map<String, WidgetBuilder> backPages;
  final String firstPage;
  final FlippableController controller;
  final Object heroTag;
  final double maxWidth;

  @override
  _FlippableState createState() => _FlippableState();
}

class _FlippableState extends State<Flippable> with TickerProviderStateMixin {
  AnimationController _rotationController;
  Animation<double> _rotationAnimation;

  WidgetBuilder _frontPageBuilder = (_) => Container(height: 0);
  WidgetBuilder _backPageBuilder = (_) => Container(height: 0);

  // TODO: Transition between pages with same side

  bool _halfFlipped = false;

  @override
  void initState() {
    super.initState();

    // Initialize rotation animation
    _rotationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);

    Animation _rotationCurve =
        CurvedAnimation(curve: Curves.easeInOut, parent: _rotationController);

    _rotationAnimation = Tween(begin: 0.0, end: Math.pi).animate(_rotationCurve)
      ..addListener(() {
        setState(() {
          // Update internal variable
          _halfFlipped = _rotationController.value >= 0.5;

          // Update the controller
          widget.controller._isFlipped = _halfFlipped;
        });
      });

    // Go to first page
    _handleNavigation(widget.firstPage ?? widget.frontPages.entries.first.key);

    // Handle controller callbacks
    widget.controller._handleNavigation = (name) {
      setState(() {
        _handleNavigation(name);
      });
    };
  }

  void _handleNavigation(String routeName) {
    // Set up new page
    WidgetBuilder newBuilder = widget.frontPages[routeName];
    if (newBuilder == null) {
      // Not a front page
      newBuilder = widget.backPages[routeName];
      if (newBuilder == null) {
        // Not a page
        throw PlatformException(
            code: 'flippable_inexistent_page',
            message: 'You are trying to navigate to an non-existent page.',
            details: '$routeName was not declared among the available pages.');
      } else {
        // A back page

        // Set the builder ready
        _backPageBuilder = newBuilder;

        // Rotate
        _rotationController.forward();

        // Notify
        widget.controller._currentRoute = routeName;
      }
    } else {
      // A front page

      // Set the builder ready
      _frontPageBuilder = newBuilder;

      // Rotate
      _rotationController.reverse();

      // Notify
      widget.controller._currentRoute = routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black.withOpacity(0.55),
          child: Center(
            child: Hero(
              tag: widget.heroTag,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0009)
                  ..translate(
                      (widget.maxWidth) * _rotationAnimation.value / Math.pi)
                  ..rotateY(_rotationAnimation.value),
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
                      constraints: BoxConstraints(maxWidth: widget.maxWidth),
                      child: Transform(
                        alignment: FractionalOffset.center,

                        // Mirror the back widget
                        transform: Matrix4.identity()
                          ..rotateY(_halfFlipped ? Math.pi : 0),
                        child: _halfFlipped
                            ? _backPageBuilder(context) ?? Container(height: 0)
                            : _frontPageBuilder(context) ??
                                Container(height: 0),
                      ),
                    ),
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
