import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/splashpage.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCHSj39ekSXXqECz9EZfrtKJy5QKLdV3JU",
      authDomain: "portfolio-app-50810.firebaseapp.com",
      projectId: "portfolio-app-50810",
      storageBucket: "portfolio-app-50810.appspot.com",
      messagingSenderId: "740649394123",
      appId: "1:740649394123:web:ae174f0eb780286d78604e",
      measurementId: "G-YBV6BNTD9K",
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
