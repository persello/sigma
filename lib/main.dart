import 'package:flutter/material.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

void main() => runApp(SigmaApp());

class SigmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      themeMode: ThemeMode.dark,
      theme:
          ThemeData(brightness: Brightness.light, primaryColor: Colors.white, fontFamily: 'RobotoCondensed'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: MainPage(title: 'Sigma'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // Backdrop
    return ScaffoldWithBackdropDrawer(
      title: Image.asset('res/sigma_letter_br.png',
          alignment: Alignment.center,
          height: 60,
          // Color only whan dark, leave bicolor when light
          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).accentColor : null),
      actionButton: Material(
        elevation: 16,
        child: Container(height: 70, width: 70, color: Colors.red, decoration: BoxDecoration(borderRadius: Radius),),
      ),
      drawerContent: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Name Surname'),
              accountEmail: Text(
                'mail@example.com',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              currentAccountPicture: Image.asset('res/sigma_letter_br.png'),
            ),
            FlatButton(
              child: ListTile(leading: Icon(OMIcons.home), title: Text('Home')),
              onPressed: () {},
            ),
            FlatButton(
              child: ListTile(leading: Icon(OMIcons.attachMoney), title: Text('Section')),
              onPressed: () {},
            ),
            FlatButton(
              child: ListTile(leading: Icon(OMIcons.creditCard), title: Text('Section 2')),
              onPressed: () {},
            ),
            Divider(),
            FlatButton(
              child: ListTile(leading: Icon(OMIcons.settings), title: Text('Settings')),
              onPressed: () {},
            ),
            FlatButton(
              child: ListTile(leading: Icon(OMIcons.info), title: Text('Help and feedback')),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              elevation: 8,
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
              elevation: 8,
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
      ),
    );
  }
}
