import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> signInUser(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code);
      return false;
    }
  }

  Future<bool> signUpUser(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.code);
      return false;
    }
  }
}
