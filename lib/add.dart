import 'package:flutter/material.dart';
import 'package:sigma/main.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sigma/widgets/radial_exapnsion.dart';

class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //MainPage(),
        Container(
          color: Colors.black.withOpacity(0.6),
        ),

        Align(
          alignment: Alignment.center,
          child: Hero(
            createRectTween: MainPage.createRectTween,
            tag: 'fab',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                child: Container(

                  // Changes color based on expense type, default needs selection.
                  // When it goes into the list, the color will cover only a small strip (or category header?).
                  color: Theme.of(context).accentColor,
                  height: 700,
                  width: 400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
