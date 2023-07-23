import 'package:flutter/material.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/cv_model.dart';

class ViewCv extends StatefulWidget {
  const ViewCv({super.key});

  @override
  State<ViewCv> createState() => _ViewCvState();
}

class _ViewCvState extends State<ViewCv> {
  FirestoreMethods firestore = FirestoreMethods();
  late CvModel model;
  bool isLoading = true;

  getUserPortfolio() async {
    model = await firestore.getCv();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getUserPortfolio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your cv')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  cvHeader(),
                  const SizedBox(height: 10),
                  Text(
                    'About ${model.name}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const Divider(),
                  Text(
                    model.aboutInfo,
                    style: const TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
    );
  }

  Widget cvHeader() {
    return Container(
      color: Colors.black54,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone: ${model.phone}',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Email: ${model.email}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Text(
            'Address: ${model.address}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
