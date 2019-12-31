import 'package:flutter/material.dart';
import 'package:sigma/widgets/flippable.dart';

class AddTestFlipPage extends StatefulWidget {
  AddTestFlipPage({Key key}) : super(key: key);

  @override
  _AddTestFlipPageState createState() => _AddTestFlipPageState();
}

class _AddTestFlipPageState extends State<AddTestFlipPage>
    with TickerProviderStateMixin {
  FlippableController _controller = FlippableController();

  @override
  Widget build(BuildContext context) {
    return Flippable(
      controller: _controller,
      frontChildren: <Widget>[
        Container(
          height: 300,
          width: 400,
          color: Colors.red,
          child: Center(
            child: FlatButton(
              child: Text('Flip'),
              onPressed: () => _controller.flipBack(),
            ),
          ),
        )
      ],
      backChildren: <Widget>[
        Container(
          height: 500,
          width: 400,
          color: Colors.green,
          child: Center(
            child: FlatButton(
              child: Text('Flip'),
              onPressed: () => _controller.flipFront(),
            ),
          ),
        )
      ],
    );
  }
}
