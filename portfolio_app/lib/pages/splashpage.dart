import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/auth/loginpage.dart';
import 'package:portfolio_app/pages/homepage.dart';
import 'package:portfolio_app/variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  getUserData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    Timer(const Duration(milliseconds: 10), () {
      if (auth.currentUser == null) {
        Variables.replace(context, const LoginPage());
      } else {
        Variables.replace(context, const HomePage());
      }
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
