import 'package:flutter/material.dart';
import 'package:sigma/main.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
          color: Colors.black.withOpacity(0.55),
        ),

        Align(
          alignment: Alignment.center,
          child: Hero(
            createRectTween: MainPage.createRectTween,
            tag: 'fab',
            child: Material(
              borderRadius: BorderRadius.circular(8),
              elevation: 16,
              child: SizedBox(
                width: 400,
                height: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      // Top should change color based on expense type, default needs selection.
                      // When it goes into the list, the color will cover only a small strip (or category header?).
                      color: Colors.transparent,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Add item',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
