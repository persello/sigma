import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

SigmaUser mainUser = SigmaUser();

class SigmaUser {
  FirebaseUser firebaseAccount;

  /// Requests a login to Firebase using a Google account.
  Future googleLogin() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
