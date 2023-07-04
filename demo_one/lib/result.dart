import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyResults extends StatefulWidget {
  const MyResults({super.key});

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {
  int amount = 0;

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    amount = prefs.getInt('amount') ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Results')),
      body: Center(child: Text('$amount')),
    );
  }
}
