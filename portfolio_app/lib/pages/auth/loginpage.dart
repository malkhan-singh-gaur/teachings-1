import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/auth_methods.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/user.dart';
import 'package:portfolio_app/pages/auth/signuppage.dart';
import 'package:portfolio_app/pages/splashpage.dart';
import 'package:portfolio_app/variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
              'SignIn',
              style: TextStyle(fontSize: 24),
            ),
            Variables.buildField(email, 'Email'),
            Variables.buildField(password, 'Password'),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => validateForm(),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Variables.push(context, const SignUpPage()),
              child: const Text('New user? Create an account'),
            ),
          ],
        ),
      ),
    );
  }

  validateForm() async {
    Variables.loading(context);
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
    bool isLoggedIn = await methods.signInUser(email.text, password.text);
    if (isLoggedIn) {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserModel user = UserModel(uid: auth.currentUser!.uid, isAdmin: false);
      firestore.uploadUserData(user).then((value) {
        Navigator.pop(context);
        Variables.replace(context, const SplashScreen());
      });
    }
  }
}
