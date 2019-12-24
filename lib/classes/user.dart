import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// The current user for this app.
SigmaUser mainUser = SigmaUser();

class SigmaUser {
  /// Information related to this user's Firebase account.
  FirebaseUser firebaseAccount;

  /// The user's accounts

  /// The user's transaction list

  /// The user's settings

  // Hidden Google and Firebase objects
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in (tries offline)
  Future signIn() async {
    firebaseAccount = await _auth.currentUser();
    if (firebaseAccount == null) {
      // TODO: Throw exception
    }
  }

  Future signOut() async {
    // final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // final AuthCredential credential = GoogleAuthProvider.getCredential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );

    // // Due to security reasons, reauthentication is required
    // firebaseAccount.reauthenticateWithCredential(credential);
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    firebaseAccount = null;
  }

  Future deleteAccount() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Due to security reasons, reauthentication is required
    firebaseAccount.reauthenticateWithCredential(credential);
    // TODO: Delete document and subcollections!

    firebaseAccount.delete();
    signOut();
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
