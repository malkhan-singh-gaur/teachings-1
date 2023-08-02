import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/experience.dart';
import 'package:portfolio_app/variables.dart';

class AddExperiences extends StatefulWidget {
  final bool isEducation;
  const AddExperiences({super.key, required this.isEducation});

  @override
  State<AddExperiences> createState() => _AddExperiencesState();
}

class _AddExperiencesState extends State<AddExperiences> {
  FirestoreMethods firestore = FirestoreMethods();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  String? startingDate;
  String? endingDate;

  Timestamp? startingTimestamp;
  Timestamp? endingTimestamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add experiences')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => selectDate(true),
                    child: Text(startingDate ?? 'Select starting date'),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => selectDate(false),
                    child: Text(endingDate ?? 'Select ending date'),
                  ),
                ),
              ],
            ),
            Variables.buildField(
              title,
              widget.isEducation ? 'Enter Course name' : 'Work Title',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: description,
                maxLines: widget.isEducation ? null : 3,
                decoration: InputDecoration(
                  isDense: true,
                  border: const OutlineInputBorder(),
                  label: Text(
                    widget.isEducation ? 'Institute name' : 'Job Description',
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (checkForm()) {
                  ExperienceModel model = ExperienceModel(
                    dateStarted: startingTimestamp!,
                    dateFinished: endingTimestamp!,
                    title: title.text,
                    description: description.text,
                  );
                  if (widget.isEducation) {
                    await firestore.editCv({
                      'education': FieldValue.arrayUnion([model.toJson()])
                    });
                  } else {
                    await firestore.editCv({
                      'experience': FieldValue.arrayUnion([model.toJson()])
                    });
                  }
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  selectDate(bool isStarting) async {
    DateTime? dateTime;

    dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (dateTime == null) {
      Fluttertoast.showToast(msg: 'Please select date');
    } else {
      if (isStarting) {
        startingTimestamp = Timestamp.fromDate(dateTime);
        startingDate = Variables.getDateString(startingTimestamp!);
      } else {
        endingTimestamp = Timestamp.fromDate(dateTime);
        endingDate = Variables.getDateString(endingTimestamp!);
      }
      setState(() {});
    }
  }

  bool checkForm() {
    if (startingTimestamp == null) {
      Fluttertoast.showToast(msg: 'Select Starting date');
      return false;
    }
    if (endingTimestamp == null) {
      Fluttertoast.showToast(msg: 'Select ending date');
      return false;
    }
    if (title.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter title');
      return false;
    }
    if (description.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter description');
      return false;
    }
    return true;
  }
}
