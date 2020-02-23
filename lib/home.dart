import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sigma/widgets/colorful_header.dart';
import 'package:sigma/widgets/custom_text_styles.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> dropdownItems = ['today', 'this week', 'this month'];
  String selectedItem = 'this week';

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
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ColorfulHeader(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  firstColor: Colors.amberAccent,
                  secondColor: Colors.red,
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
                                    fontSize: 38, color: Theme.of(context).cardColor.withOpacity(0.9))),
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
                          child: Row(children: <Widget>[Text('View details'), Icon(Icons.chevron_right)]),
                          textColor: Theme.of(context).cardColor.withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 80,
                      color: Colors.black.withOpacity(index * 0.1),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
