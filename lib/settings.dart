import 'package:flutter/material.dart';
import 'package:sigma/classes/user.dart';
import 'package:sigma/settings_user.dart';
import 'package:sigma/widgets/list_menu_items.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          ButtonMaterialMenuItem(title: 'Appearance', subtitle: 'Green, system brightness'),
          ButtonMaterialMenuItem(title: 'Accounts', subtitle: 'Add, edit or remove accounts and cards'),
          ButtonMaterialMenuItem(
            title: 'Google account',
            subtitle: '${mainUser.firebaseAccount?.displayName ?? 'Log in with Google'}',
            isLastItem: true,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserSettingsPage()));
            },
          )
        ],
      ),
    );
  }
}
