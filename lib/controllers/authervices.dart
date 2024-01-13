import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // create new account using email and password
  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // login using email and password

  Future<String> loginUsingEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  // logout the user

  Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  // check whether the user is signed in
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  //  for login with google
  Future<String> continueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? authg =
          await googleUser!.authentication;

      final creds = GoogleAuthProvider.credential(
        accessToken: authg?.accessToken,
        idToken: authg?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Logged In With Google";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
