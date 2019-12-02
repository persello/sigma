import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Sigma'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _dragAccepted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
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
    // Backdrop
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onHorizontalDragStart: (DragStartDetails details) {
              if (_controller.value > 0.5 ? details.globalPosition.dx > _controller.value * 100 : details.globalPosition.dx < 30) {
                _dragAccepted = true;
              } else {
                _dragAccepted = false;
              }
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              if (_dragAccepted) {
                _controller.value += (details.delta.dx / 100);
              }
            },
            onHorizontalDragEnd: (DragEndDetails details) {
              if (_dragAccepted) {
                print(details.velocity.pixelsPerSecond.dx);
                if (details.velocity.pixelsPerSecond.dx == 0) {
                  if (_controller.value >= 0.5)
                    _controller.forward();
                  else
                    _controller.reverse();
                } else if (details.velocity.pixelsPerSecond.dx > 0)
                  _controller.forward();
                else
                  _controller.reverse();
              }
            },
            child: Transform.translate(
              offset: Offset(_controller.value * 100, 0),
              child: Material(
                elevation: 16,
                // borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    brightness: Theme.of(context).brightness,
                    textTheme: Theme.of(context).textTheme,
                    iconTheme: Theme.of(context).iconTheme,
                    elevation: 0,
                    centerTitle: true,
                    title: Text('E'),
                    leading: IconButton(
                      onPressed: () {
                        _controller.value > 0.5 ? _controller.reverse() : _controller.forward();
                      },
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
