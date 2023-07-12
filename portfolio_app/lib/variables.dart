import 'package:flutter/material.dart';

class Variables {
  static Widget buildField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: hint,
        ),
      ),
    );
  }

  static loading(context, {String? text}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(width: 15),
              Text(text ?? 'Loading...'),
            ],
          ),
        );
      },
    );
  }

  static isMobile(context) {
    return MediaQuery.sizeOf(context).width < 650;
  }

  static width(context) {
    return MediaQuery.sizeOf(context).width;
  }

  static push(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static replace(context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }
}
