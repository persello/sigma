import 'package:flutter/material.dart';

/// A [Scaffold] with a drawer which appears under it.
///
/// The drawer contains [drawerContent] and whan opened has a width of [maximumDrawerWidth],
/// the [title] is the widget that will be put in the middle of the scaffold's [AppBar], [body]
/// specifies the content of the [Scaffold]'s body.
class ScaffoldWithBackdropDrawer extends StatefulWidget {
  ScaffoldWithBackdropDrawer(
      {Key key, this.body, this.drawerContent, this.title, this.maximumDrawerWidth = 250})
      : super(key: key);

  /// The content of the [Scaffold]'s body.
  final Widget body;

  /// The content of the side drawer.
  final Widget drawerContent;

  /// The widget at the top center of the view, inside the [AppBar].
  final Widget title;

  /// The maximum expanded size of the side drawer.
  final int maximumDrawerWidth;

  @override
  _ScaffoldWithBackdropDrawerState createState() => _ScaffoldWithBackdropDrawerState();
}

class _ScaffoldWithBackdropDrawerState extends State<ScaffoldWithBackdropDrawer>
    with SingleTickerProviderStateMixin {
  // Animation
  AnimationController _controller;
  Animation _drawerCurve;

  // Interaction
  bool _dragging = false;

  @override
  void initState() {
    super.initState();

    // Different times, as specified in the Material Design guidelines
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 250),
        reverseDuration: const Duration(milliseconds: 200),
        vsync: this);

    // Played backwards is an EaseIn
    _drawerCurve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Same color as the scaffold
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          // Drawer content first, so it goes below
          widget.drawerContent,

          // Then the scaffold's container
          GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              // Drawer opened: Action must start on the front Material pane
              // Drawer closed: Action must start near the edge
              if (_controller.value > 0.5
                  ? details.globalPosition.dx > _controller.value * widget.maximumDrawerWidth
                  : details.globalPosition.dx < 30) {
                // Drag recognized
                _dragging = true;
              } else {
                // Drag rejected
                _dragging = false;
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (_dragging) {
                // Integrate delta if drag was accepted
                _controller.value += (details.delta.dx / widget.maximumDrawerWidth);
              }
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              // Only if the interaction was recognized
              if (_dragging) {
                if (details.velocity.pixelsPerSecond.dx == 0) {
                  // If at the last point the cursor was still
                  // Let's see the position, move to nearest snap point
                  if (_controller.value >= 0.5)
                    _controller.forward(from: _controller.value);
                  else
                    _controller.reverse(from: _controller.value);
                } else if (details.velocity.pixelsPerSecond.dx > 0)
                  // If it was moving towards the center of the screen, go to opened state
                  _controller.forward(from: _controller.value);
                else
                  // If it was moving towards the edge of the screen, go to closed state
                  _controller.reverse(from: _controller.value);
              }
              _dragging = false;
            },
            child: Transform.translate(
              // Use the controller's value while dragged, the animation's value when opened by tapping
              offset: Offset((_dragging ? _controller : _drawerCurve).value * widget.maximumDrawerWidth, 0),
              
              // The material widget behind the scaffold
              child: Material(
                elevation: 24,
                // Scaffold color because scaffold is transparent
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  // Get body from properties
                  body: widget.body,
                  appBar: AppBar(
                    // Transparent, get theme from theme data
                    backgroundColor: Colors.transparent,
                    brightness: Theme.of(context).brightness,
                    textTheme: Theme.of(context).textTheme,
                    iconTheme: Theme.of(context).iconTheme,
                    elevation: 0,
                    centerTitle: true,
                    // Get title from properties
                    title: widget.title,
                    // Menu button
                    leading: IconButton(
                      onPressed: () {
                        _controller.value > 0.5
                            ? _controller.reverse(from: _controller.value)
                            : _controller.forward(from: _controller.value);
                      },
                      // Progress given by controller, so it is linear
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_arrow,
                        progress: _controller,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
