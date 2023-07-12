import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/auth_methods.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/user.dart';
import 'package:portfolio_app/pages/splashpage.dart';
import 'package:portfolio_app/variables.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'SignUp',
              style: TextStyle(fontSize: 24),
            ),
            Variables.buildField(email, 'Email'),
            Variables.buildField(password, 'Password'),
            Variables.buildField(cpassword, 'Confirm Password'),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => validateForm(),
              child: const Text('SignUp'),
            ),
          ],
        ),
      ),
    );
  }

  validateForm() async {
    AuthMethods methods = AuthMethods();
    FirestoreMethods firestore = FirestoreMethods();
    if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please provide email');
      return;
    }
    if (password.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please provide a password');
      return;
    }
    if (password.text != cpassword.text) {
      Fluttertoast.showToast(
          msg: 'Password and confirm password should be same');
      return;
    }
    bool isLoggedIn = await methods.signUpUser(email.text, password.text);
    if (isLoggedIn) {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserModel user = UserModel(uid: auth.currentUser!.uid, isAdmin: false);
      firestore.uploadUserData(user).then((value) {
        Variables.replace(context, const SplashScreen());
      });
    }
  }
}
