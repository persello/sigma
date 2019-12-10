import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sigma/add.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:sigma/widgets/corner_radius_transition.dart';
import 'package:sigma/widgets/transparent_route.dart';

void main() => runApp(SigmaApp());

class SigmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.pink,
          primaryColor: Colors.white,
          fontFamily: 'RobotoCondensed'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => MainPage(),
        '/add': (context) => AddPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  static RectTween createRectTween(Rect begin, Rect end) {
    return MaterialRectArcTween(begin: begin, end: end);
  }

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // Backdrop
    return ScaffoldWithBackdropDrawer(
      title: Image.asset('res/sigma_letter_br.png',
          alignment: Alignment.center,
          height: 60,
          // Color only whan dark, leave bicolor when light
          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).accentColor : null),
      actionButton: ButtonTheme(
        minWidth: 60,
        height: 60,
        child: Hero(
          flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
            Hero toHero = direction == HeroFlightDirection.push ? toContext.widget : fromContext.widget;

            return ButtonToCardTransition(
                // child: toHero.child,
                startCornerRadius: 30,
                endCornerRadius: 8,
                sizeAnim: animation,
                startColor: Theme.of(fromContext).accentColor,
                endColor: Theme.of(toContext).scaffoldBackgroundColor);
          },
          createRectTween: MainPage.createRectTween,
          tag: 'fab',
          child: RaisedButton(
            elevation: 8,
            highlightElevation: 2,
            color: Theme.of(context).accentColor,
            child: Icon(Icons.add),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            onPressed: () {
              Navigator.push(context, TransparentPageRoute(builder: (context) => AddPage()));
            },
          ),
        ),
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
      ),
    );
  }
}
