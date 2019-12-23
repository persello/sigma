import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

SigmaUser mainUser = SigmaUser();

class SigmaUser {
  FirebaseUser firebaseAccount;

  // Hidden Google and Firebase objects
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in (tries offline)
  Future signIn() async {
    firebaseAccount = await _auth.currentUser();
    // if (_user == null) {
    //   _user =
    //       await _auth.signInWithEmailAndPassword(email: account, password: myPassword).catchError((error) {
    //     print(error);
    //   });
    // }
  }

  /// Requests a login to Firebase using a Google account.
  Future googleLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    firebaseAccount = (await _auth.signInWithCredential(credential)).user;
    // TODO: Manage errors
  }
}
