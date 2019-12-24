import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma/widgets/list_menu_items.dart';

import 'classes/user.dart';

class UserSettingsPage extends StatefulWidget {
  UserSettingsPage({Key key}) : super(key: key);

  @override
  _UserSettingsPageState createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User settings'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Material(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      height: 80,
                      placeholder: (context, url) => Image.asset('res/sigma_letter_br.png', height: 80),
                      imageUrl: mainUser.firebaseAccount?.photoUrl ?? '',
                      errorWidget: (context, url, error) => Image.asset(
                        'res/sigma_letter_br.png',
                        height: 80,
                      ),
                    ),
                  ),
                  Container(width: 24),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          mainUser.firebaseAccount?.displayName ?? 'Guest',
                          style: Theme.of(context).textTheme.headline,
                          textAlign: TextAlign.center,
                        ),
                        Text(mainUser.firebaseAccount?.email ?? 'Account not connected',
                            style: Theme.of(context).textTheme.caption)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (mainUser.firebaseAccount != null)
                ? TextMaterialMenuItem(
                    title: 'Last login',
                    subtitle: DateFormat.yMMMMEEEEd().add_Hms().format(
                          mainUser.firebaseAccount.metadata.lastSignInTime.toLocal(),
                        ),
                  )
                : Container(),
            (mainUser.firebaseAccount != null)
                ? ButtonMaterialMenuItem(
                    title: 'Sign out',
                    subtitle: 'Disconnect from Sigma',
                    onPressed: () {
                      mainUser.signOut().then((s) => setState(() {}));
                    },
                  )
                : ButtonMaterialMenuItem(
                    title: 'Sign in',
                    subtitle: 'Connect your Google account to Sigma',
                    onPressed: () {
                      mainUser.googleLogin().then((s) => setState(() {}));
                    }),
            
                ButtonMaterialMenuItem(
                    title: 'Delete your account',
                    subtitle: 'Delete all your data from the Sigma app and server',
                    // onPressed: (mainUser.firebaseAccount != null) ? () {
                    //   mainUser.deleteAccount().then((s) => setState(() {}));
                    // } : null,
                  )
          ],
        ),
      ),
    );
  }
}
