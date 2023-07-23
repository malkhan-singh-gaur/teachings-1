import 'package:flutter/material.dart';
import 'package:portfolio_app/pages/add_about.dart';
import 'package:portfolio_app/pages/add_basic_info.dart';
import 'package:portfolio_app/pages/add_skills.dart';
import 'package:portfolio_app/pages/view_cv.dart';
import 'package:portfolio_app/variables.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          TextButton(
            child: const Text('View Cv'),
            onPressed: () => Variables.push(context, const ViewCv()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton(
              onPressed: () => Variables.push(context, const AddBasicInfo()),
              child: const Text('Add Basic info'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Variables.push(context, const AddAboutPage()),
              child: const Text('Add About information'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () => Variables.push(context, const AddSkillPage()),
              child: const Text('Add skills'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
