import 'package:flutter/material.dart';
import 'package:sigma/widgets/drawer_button.dart';

/// An item for a side drawer. Usually leads to another page.
class DrawerMenuEntry {
  DrawerMenuEntry({@required this.name, @required this.onPressed, this.icon});

  /// The icon shown before the name.
  final IconData icon;

  /// The name of the entry.
  final String name;

  /// The function called when the button is pressed. The drawer is closed automatically.
  final Function() onPressed;
}

/// A [Scaffold] with a drawer which appears under it.
///
/// The drawer contains [drawerContent] and whan opened has a width of [maximumDrawerWidth],
/// the [title] is the widget that will be put in the middle of the scaffold's [AppBar], [body]
/// specifies the content of the [Scaffold]'s body.
class ScaffoldWithBackdropDrawer extends StatefulWidget {
  ScaffoldWithBackdropDrawer(
      {Key key,
      this.body,
      this.drawerHeader,
      @required this.drawerEntries,
      this.title,
      this.maximumDrawerWidth = 250,
      this.actionButton})
      : super(key: key);

  /// The content of the [Scaffold]'s body.
  final Widget body;

  /// The header of the side drawer.
  final Widget drawerHeader;

  /// The drawer's menu items.
  final List<DrawerMenuEntry> drawerEntries;

  /// The floating action button.
  final Widget actionButton;

  /// The widget at the top center of the view, inside the [AppBar].
  final Widget title;

  /// The maximum expanded size of the side drawer.
  final double maximumDrawerWidth;

  @override
  _ScaffoldWithBackdropDrawerState createState() => _ScaffoldWithBackdropDrawerState();
}

class _ScaffoldWithBackdropDrawerState extends State<ScaffoldWithBackdropDrawer>
    with SingleTickerProviderStateMixin {
  // Animation
  AnimationController _controller;
  Animation _drawerCurve;

  int selectedEntry = 0;

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
          // Drawer content
          SizedBox(
            width: widget.maximumDrawerWidth,
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  widget.drawerHeader ?? Container(),
                  // Builds a list of FlatButtons
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.only(right: 8),
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.drawerEntries?.length ?? 0,
                      itemBuilder: (context, index) {
                        return DrawerButton(
                          icon: widget.drawerEntries[index].icon,
                          name: widget.drawerEntries[index].name,
                          rightSideCornerRadius: 32,
                          selected: index == selectedEntry,
                          onPressed: () {
                            // Update last selection
                            setState(() {
                              selectedEntry = index;
                            });

                            // Closes the drawer then calls the associated function
                            _controller.reverse();
                            widget.drawerEntries[index].onPressed();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

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
            child: Transform(
              transform: Matrix4.identity()
                /*..setEntry(3, 2, 0.0004)
                ..rotateY((_dragging ? _controller : _drawerCurve).value * 0.5)*/
                ..translate(
                    // Use the controller's value while dragged, the animation's value when opened by tapping
                    (_dragging ? _controller : _drawerCurve).value * widget.maximumDrawerWidth,
                    0),
              // The material widget behind the scaffold
              child: Material(
                elevation: 16,
                // Scaffold color because scaffold is transparent
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  // Get body from properties
                  body: widget.body,
                  floatingActionButton: widget.actionButton,
                  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                      tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
