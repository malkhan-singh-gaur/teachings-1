import 'package:demo_one/form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'My app';
  String imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQIbXiFSs6bFoTbWt2tlmzOUuntjbnmJfjgg&usqp=CAU';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              title = 'App bar title';
              setState(() {});
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: const Center(
        child: Text('Hit the button'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return const MyForm();
          }));
        },
      ),
    );
  }
}
