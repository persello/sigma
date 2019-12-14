import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
      return Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '123.45\$',
                      style: TextStyle(
                          fontSize: 36, fontFamily: 'LibreCaslonDisplay', fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '123.45\$',
                      style: TextStyle(
                          fontSize: 36, fontFamily: 'LibreCaslonDisplay', fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}