import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/cv_model.dart';
import 'package:portfolio_app/variables.dart';

class AddBasicInfo extends StatefulWidget {
  const AddBasicInfo({super.key});

  @override
  State<AddBasicInfo> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddBasicInfo> {
  FirestoreMethods firestore = FirestoreMethods();
  CvModel? cvModel;

  TextEditingController name = TextEditingController();
  TextEditingController currentJob = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController twitter = TextEditingController();
  TextEditingController linkedIn = TextEditingController();
  TextEditingController gitHub = TextEditingController();

  getUserPortfolio() async {
    CvModel cv = await firestore.getCv();
    cvModel = cv;
    name = TextEditingController(text: cv.name);
    phone = TextEditingController(text: cv.phone);
    email = TextEditingController(text: cv.email);
    address = TextEditingController(text: cv.address);
    twitter = TextEditingController(text: cv.twitterLink);
    linkedIn = TextEditingController(text: cv.linkedInLink);
    gitHub = TextEditingController(text: cv.gitHubLink);
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
      appBar: AppBar(title: const Text('Add name')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Variables.buildField(name, 'Enter your name'),
            Variables.buildField(currentJob, 'Enter your Current Job'),
            Variables.buildField(phone, 'Phone number'),
            Variables.buildField(email, 'Email'),
            Variables.buildField(address, 'Your Address'),
            const Text(
              'Links',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            Variables.buildField(twitter, 'Twitter'),
            Variables.buildField(linkedIn, 'LinkedIn'),
            Variables.buildField(gitHub, 'Github'),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                if (checkForm()) {
                  CvModel model = CvModel(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    name: name.text,
                    phone: phone.text,
                    email: email.text,
                    address: address.text,
                    twitterLink: twitter.text.trim(),
                    linkedInLink: linkedIn.text.trim(),
                    gitHubLink: gitHub.text.trim(),
                    aboutInfo: cvModel!.aboutInfo,
                    skills: cvModel!.skills,
                    experience: cvModel!.experience,
                    projects: cvModel!.projects,
                    languages: cvModel!.languages,
                    currentJob: cvModel!.currentJob,
                    education: cvModel!.education,
                    achievements: cvModel!.achievements,
                    programmingLanguages: cvModel!.programmingLanguages,
                    hobbies: cvModel!.hobbies,
                  );
                  await firestore.editCv(model.toJson()).then(
                    (value) {
                      Fluttertoast.showToast(msg: 'Changes saved');
                      Navigator.pop(context);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  bool checkForm() {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter name');
      return false;
    }
    if (phone.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter phone');
      return false;
    }
    if (email.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter email');
      return false;
    }
    if (address.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter address');
      return false;
    }
    return true;
  }
}
