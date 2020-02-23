import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:sigma/widgets/custom_text_styles.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dropdownItems = ['today', 'this week', 'this month'];
  String selectedItem = 'this week';

  StreamSubscription<GyroscopeEvent> gyroStream;

  double gx = 0;
  double gy = 0;

  @override
  void initState() {
    gyroStream = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        gx += event.y > 5 ? 5 : event.y;
        gy += event.x > 5 ? 5 : event.x;

        // Return to home
        gx -= gx / 10;
        gy -= gy / 10;
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
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(8),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.lerp(Colors.red, Colors.amberAccent, 0.75),
                            blurRadius: 12,
                            offset: Offset(0, -2))
                      ],
                      gradient: RadialGradient(
                        colors: [Colors.amberAccent, Colors.red],
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
                              duration: Duration(milliseconds: 200),
                              height: 100,
                              width: 100,
                              transform: Matrix4.identity()
                                ..scale(6.00)
                                ..translate(-15.00 + gx, -20.00 + gy),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.amberAccent.withOpacity(0.6),
                                      blurRadius: 3,
                                      offset: Offset(-24 + gx, 24 + gy))
                                ],
                                backgroundBlendMode: BlendMode.lighten,
                                borderRadius: BorderRadius.circular(50),
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.amberAccent.withAlpha(0),
                                    Colors.amberAccent.withOpacity(0.4)
                                  ],
                                  center: Alignment.center,
                                  stops: [0.7, 1],
                                  radius: 0.5,
                                ),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            duration: Duration(milliseconds: 200),
                            transform: Matrix4.identity()..translate(gx * 1.5, gy * 1.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: <Widget>[
                                      Text(r'171.43$',
                                          style: CustomTextStyles.moneyDisplayStyle.copyWith(
                                              fontSize: 38,
                                              color: Theme.of(context).cardColor.withOpacity(0.9))),
                                      Text(
                                        ' spent ',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).cardColor.withOpacity(0.9),
                                        ),
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isDense: true,
                                          value: selectedItem,
                                          onChanged: (String string) => setState(() => selectedItem = string),
                                          selectedItemBuilder: (BuildContext context) {
                                            return dropdownItems.map<Widget>((String item) {
                                              return Text(
                                                item,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).cardColor.withOpacity(0.6),
                                                ),
                                              );
                                            }).toList();
                                          },
                                          items: dropdownItems.map((String item) {
                                            return DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList(),
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber,
                                          ),
                                          iconEnabledColor: Theme.of(context).cardColor.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ButtonTheme(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Row(children: <Widget> [Text('View details'), Icon(Icons.chevron_right)]),
                                    textColor: Theme.of(context).cardColor.withOpacity(0.6),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  height: 300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
