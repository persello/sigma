import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sigma/add.dart';
import 'package:sigma/home.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:sigma/widgets/fab_hero_radius.dart';
import 'package:sigma/widgets/transparent_route.dart';

void main() => runApp(SigmaApp());

class SigmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          brightness: Brightness.light,
          accentColor: Colors.pinkAccent,
          primaryColor: Colors.blueGrey,
          fontFamily: 'RobotoCondensed'),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => MainPage(),
        '/home': (context) => HomePage(),
        '/home/add': (context) => AddPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final secondaryNavigatorKey = GlobalKey<NavigatorState>();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Backdrop
    return ScaffoldWithBackdropDrawer(
      title: Image.asset('res/sigma_letter_br.png',
          alignment: Alignment.center,
          height: 60,
          // Color only whan dark, leave bicolor when light
          color: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).accentColor : null),
      actionButton: FloatingActionButtonWithCornerHeroTransition(
        icon: Icons.add,
        heroTag: 'fab',
        toHeroColor: Theme.of(context).scaffoldBackgroundColor,
        toHeroCornerRadius: 8,
        onPressed: () {
          Navigator.push(context, TransparentPageRoute(builder: (context) => AddPage()));
        },
      ),
      drawerContent: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Name Surname', style: Theme.of(context).textTheme.subhead),
              accountEmail: Text('mail@example.com', style: Theme.of(context).textTheme.subtitle),
              currentAccountPicture: Image.asset('res/sigma_letter_br.png'),
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
            ),
            FlatButton(
              child:
                  ListTile(leading: Icon(OMIcons.home), title: Text('Home'), selected: currentPageIndex == 0),
              onPressed: () {
                if (currentPageIndex != 0) secondaryNavigatorKey.currentState.pushNamed('/home');
                // INTEGRATE IN SCAFFOLD FOR CONTROLLING WHEN TO CLOSE.
              },
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
      body: Navigator(
        key: secondaryNavigatorKey,
        initialRoute: '/home',
        onGenerateRoute: (route) => MaterialPageRoute(
          settings: route,
          builder: (context) => HomePage(),
        ),
      ),
    );
  }
}
