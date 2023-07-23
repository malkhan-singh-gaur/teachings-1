import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';

class AddAboutPage extends StatefulWidget {
  const AddAboutPage({super.key});

  @override
  State<AddAboutPage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddAboutPage> {
  TextEditingController controller = TextEditingController();
  FirestoreMethods firestore = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add about info')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: controller,
                maxLines: 10,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Describe about yourself',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                if (checkForm()) {
                  await firestore
                      .editCv({'aboutInfo': controller.text}).then((value) {
                    Fluttertoast.showToast(msg: 'Changes saved');
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool checkForm() {
    if (controller.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter name');
      return false;
    }
    return true;
  }
}
