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

  Widget mainPage(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.yellow,
      child: Center(
        child: FlatButton(
          child: Text('FLIP BACK'),
          onPressed: () => _controller.navigate('/home/add/back'),
        ),
      ),
    );
  }

  Widget exampleBack(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.green,
      child: Center(
        child: FlatButton(
          child: Text('FLIP MAIN'),
          onPressed: () => _controller.navigate('/home/add/main'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flippable(
      controller: _controller,
      heroTag: 'fab',
      frontPages: <String, WidgetBuilder>{
        '/home/add/main': mainPage,
      },
      backPages: <String, WidgetBuilder>{
        '/home/add/back': exampleBack,
      },
    );
  }
}
