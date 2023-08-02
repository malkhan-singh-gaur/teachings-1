import 'package:flutter/material.dart';
import 'package:portfolio_app/methods/firestore_methods.dart';
import 'package:portfolio_app/models/cv_model.dart';
import 'package:portfolio_app/models/experience.dart';
import 'package:portfolio_app/variables.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  cvHeader(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(model.aboutInfo),
                  ),
                  const Divider(),
                  headingText('Skills and Competencies'),
                  for (var skill in model.skills)
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: skillText(skill),
                    ),
                  const Divider(),
                  headingText('Educational Background'),
                  for (var education in model.education
                      .map((e) => ExperienceModel.fromJson(e))
                      .toList())
                    experienceText(education),
                  const Divider(),
                  headingText('Work Experience'),
                  for (var education in model.experience
                      .map((e) => ExperienceModel.fromJson(e))
                      .toList())
                    experienceText(education),
                ],
              ),
            ),
    );
  }

  Padding experienceText(ExperienceModel education) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Variables.getMonthYear(education.dateStarted),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  Variables.getMonthYear(education.dateFinished),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(education.description),
            ],
          ),
        ],
      ),
    );
  }

  Widget headingText(String text) {
    return ListTile(
      leading: const Icon(Icons.category),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget skillText(String text) {
    return ListTile(
      leading: const Icon(Icons.star),
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Text(text),
    );
  }

  Widget cvHeader() {
    return Container(
      color: Colors.black87,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    paddingText('Phone:', model.phone),
                    if (model.twitterLink.isNotEmpty)
                      paddingText('Twitter:', model.twitterLink),
                  ],
                ),
                Wrap(
                  children: [
                    paddingText('Email:', model.email),
                    if (model.twitterLink.isNotEmpty)
                      paddingText('GitHub:', model.gitHubLink),
                  ],
                ),
                Wrap(
                  children: [
                    paddingText('Address:', model.address),
                    if (model.twitterLink.isNotEmpty)
                      paddingText('LinkedIn:', model.linkedInLink),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isLink(String text) {
    if (text.startsWith('http') || text.startsWith('www')) {
      return true;
    }

    return false;
  }

  Widget paddingText(String hint, String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: isLink(text)
            ? () async {
                String link = text.replaceAll('www.', 'https://');
                Uri? uri = Uri.tryParse(link);
                if (uri != null) {
                  bool isLink = await launcher.canLaunchUrl(uri);
                  if (isLink) {
                    await launcher.launchUrl(uri);
                  }
                }
              }
            : null,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$hint ',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: text,
                style: TextStyle(
                  color: isLink(text) ? Colors.blue : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
