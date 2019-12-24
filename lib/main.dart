import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:sigma/add.dart';
import 'package:sigma/classes/user.dart';
import 'package:sigma/home.dart';
import 'package:sigma/settings.dart';
import 'package:sigma/settings_user.dart';
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
      initialRoute: '/home',
      routes: <String, WidgetBuilder>{
        '/home': (context) => MainPage(),
        '/home/add': (context) => AddPage(),
        '/settings/user': (context) => UserSettingsPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  Widget body = HomePage();

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
      actionButton: (body is HomePage)
          ? FloatingActionButtonWithCornerHeroTransition(
              icon: Icons.add,
              heroTag: 'fab',
              toHeroColor: Theme.of(context).scaffoldBackgroundColor,
              toHeroCornerRadius: 8,
              onPressed: () {
                Navigator.push(context, TransparentPageRoute(builder: (context) => AddPage()));
              },
            )
          : null,
      drawerHeader: UserAccountsDrawerHeader(
        arrowColor: Colors.transparent,
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
          Navigator.of(context).pushNamed('/settings/account');
        },
      ),
      drawerEntries: <DrawerMenuEntry>[
        DrawerMenuEntry(
            name: 'Home',
            icon: OMIcons.home,
            onPressed: () {
              setState(() {
                body = HomePage();
              });
            }),
        DrawerMenuEntry(name: 'Accounts', icon: OMIcons.attachMoney, onPressed: () {}),
        DrawerMenuEntry(name: 'Data', icon: OMIcons.barChart, onPressed: () {}),
        DrawerMenuEntry(name: 'History', icon: OMIcons.calendarToday, onPressed: () {}),
        DrawerMenuEntry(
            name: 'Settings',
            icon: OMIcons.settings,
            onPressed: () {
              setState(() {
                body = SettingsPage();
              });
            }),
        DrawerMenuEntry(name: 'Help and feedback', icon: OMIcons.info, onPressed: () {}),
      ],
      body: body,
    );
  }
}
