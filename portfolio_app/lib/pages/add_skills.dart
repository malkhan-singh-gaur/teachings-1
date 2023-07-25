import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/cv_model.dart';
import 'package:portfolio_app/variables.dart';

class AddSkillPage extends StatefulWidget {
  const AddSkillPage({super.key});

  @override
  State<AddSkillPage> createState() => _AddSkillPageState();
}

class _AddSkillPageState extends State<AddSkillPage> {
  FirestoreMethods firestore = FirestoreMethods();
  TextEditingController skill = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add skill')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Variables.buildField(skill, 'Skill name'),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              if (checkForm()) {
                await firestore.editCv({
                  'skills': FieldValue.arrayUnion([skill.text]),
                }).then((value) {
                  Fluttertoast.showToast(msg: 'Changes saved');
                  skill.clear();
                  setState(() {});
                });
              }
            },
          ),
          const Divider(),
          StreamBuilder(
            stream:
                firestore.portfolioCollection.doc(firestore.uid).snapshots(),
            builder: (_, AsyncSnapshot<DocumentSnapshot> snap) {
              if (snap.data == null) {
                return const SizedBox.shrink();
              } else {
                CvModel model = CvModel.fromSnap(snap.requireData);
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.skills.length,
                  itemBuilder: (context, int i) {
                    return Card(
                      child: ListTile(
                        title: Text(model.skills[i]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            await firestore.editCv({
                              'skills':
                                  FieldValue.arrayRemove([model.skills[i]]),
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
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
    return true;
  }
}
