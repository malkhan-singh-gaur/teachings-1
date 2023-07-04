import 'package:demo_one/result.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Amount',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                if (controller.text.isNotEmpty) {
                  int initialAmmount = prefs.getInt('amount') ?? 0;

                  prefs.setInt(
                      'amount', (initialAmmount + int.parse(controller.text)));
                  debugPrint('done');
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return MyResults();
                  }));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Type an ammount'),
                    ),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
