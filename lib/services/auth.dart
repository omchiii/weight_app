import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_weight_app/models/AnonUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AnonUser _userFromFirebaseUser(User user) {
    return user != null ? AnonUser(uid: user.uid) : null;
  }

  Stream<AnonUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
    }
  }
}
