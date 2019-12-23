import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(64),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Log in to Sigma',
                      style: Theme.of(context).textTheme.display1,
                    ),
                    Image.asset('res/icon/foreground_1024.png'),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonHeight: 48,
              buttonMinWidth: 120,
              buttonPadding: EdgeInsets.all(16),
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'NO, THANKS',
                  ),
                  onPressed: () {},
                ),
                RaisedButton(
                  color: Theme.of(context).buttonTheme.colorScheme.primary,
                  child: Text(
                    'LOG IN',
                  ),
                  onPressed: () {
                    _handleSignIn().then((FirebaseUser user) => print(user)).catchError((e) => print(e));
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
