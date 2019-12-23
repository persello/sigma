import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sigma/add.dart';
import 'package:sigma/classes/user.dart';
import 'package:sigma/home.dart';
import 'package:sigma/login.dart';
import 'package:sigma/widgets/backdrop_drawer_scaffold.dart';
import 'package:sigma/widgets/fab_hero_radius.dart';
import 'package:sigma/widgets/transparent_route.dart';

void main() => runApp(SigmaApp());

class SigmaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sigma',
      themeMode: ThemeMode.system,
      theme: ThemeData(
          brightness: Brightness.light, accentColor: Colors.pinkAccent, primaryColor: Colors.blueGrey),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => MainPage(),
        '/home': (context) => HomePage(),
        '/home/add': (context) => AddPage(),
        '/login': (context) => LoginPage(),
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
  void initState() {
    super.initState();
    login();
  }

  void login() async {
    mainUser.signIn().then((s) {
      setState(() {
        mainUser = mainUser;
      });
    });
  }

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
      drawerHeader: UserAccountsDrawerHeader(
        accountName: Text(mainUser.firebaseAccount?.displayName ?? 'Guest',
            style: Theme.of(context).textTheme.subhead),
        accountEmail: Text(mainUser.firebaseAccount?.email ?? 'No address',
            style: Theme.of(context).textTheme.subtitle),
        currentAccountPicture: ClipOval(
          child: CachedNetworkImage(
            placeholder: (context, url) => Image.asset('res/sigma_letter_br.png'),
            imageUrl: mainUser.firebaseAccount?.photoUrl ?? '',
            errorWidget: (context, url, error) => Image.asset('res/sigma_letter_br.png'),
          ),
        ),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        onDetailsPressed: () {
          Navigator.of(context).pushNamed('/login');
        },
      ),
      drawerEntries: <DrawerMenuEntry>[
        DrawerMenuEntry(name: 'Home', icon: OMIcons.home, onPressed: () {}),
        DrawerMenuEntry(name: 'Accounts', icon: OMIcons.attachMoney, onPressed: () {}),
        DrawerMenuEntry(name: 'Data', icon: OMIcons.barChart, onPressed: () {}),
        DrawerMenuEntry(name: 'History', icon: OMIcons.calendarToday, onPressed: () {}),
        DrawerMenuEntry(name: 'Settings', icon: OMIcons.settings, onPressed: () {}),
        DrawerMenuEntry(name: 'Help and feedback', icon: OMIcons.info, onPressed: () {}),
      ],
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
