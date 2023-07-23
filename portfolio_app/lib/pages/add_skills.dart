import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/skills.dart';
import 'package:portfolio_app/variables.dart';

class AddSkillPage extends StatefulWidget {
  const AddSkillPage({super.key});

  @override
  State<AddSkillPage> createState() => _AddSkillPageState();
}

class _AddSkillPageState extends State<AddSkillPage> {
  FirestoreMethods firestore = FirestoreMethods();

  TextEditingController skill = TextEditingController();
  TextEditingController yearsOfExperience = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add skill')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Variables.buildField(skill, 'Skill name'),
          Variables.buildField(yearsOfExperience, 'Experience in this skill'),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              if (checkForm()) {
                SkillModel model = SkillModel(
                  skill: skill.text,
                  yearsOfExperience: yearsOfExperience.text,
                );
                await firestore.editCv({
                  'skills': FieldValue.arrayUnion([model.toJson()]),
                }).then((value) {
                  Fluttertoast.showToast(msg: 'Changes saved');
                  Navigator.pop(context);
                });
              }
            },
          ),
        ],
      ),
    );
  }

  bool checkForm() {
    if (skill.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter name');
      return false;
    }
    if (yearsOfExperience.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter phone');
      return false;
    }
    return true;
  }
}
