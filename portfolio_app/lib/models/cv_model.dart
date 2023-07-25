import 'package:cloud_firestore/cloud_firestore.dart';

class CvModel {
  final String uid;
  final String name;
  final String currentJob;
  final String twitterLink;
  final String linkedInLink;
  final String gitHubLink;
  final String phone;
  final String email;
  final String address;
  final String aboutInfo;
  final List skills;
  final List experience;
  final List education;
  final List achievements;
  final List programmingLanguages;
  final List languages;
  final List hobbies;
  final List projects;

  CvModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.aboutInfo,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.languages,
    required this.currentJob,
    required this.twitterLink,
    required this.linkedInLink,
    required this.gitHubLink,
    required this.education,
    required this.achievements,
    required this.programmingLanguages,
    required this.hobbies,
  });

  factory CvModel.fromSnap(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    return CvModel(
      uid: data['uid'],
      name: data['name'],
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      aboutInfo: data['aboutInfo'],
      skills: data['skills'] ?? [],
      experience: data['experience'] ?? [],
      projects: data['projects'] ?? [],
      languages: data['languages'] ?? [],
      currentJob: data['currentJob'] ?? '',
      twitterLink: data['twitterLink'] ?? '',
      linkedInLink: data['linkedInLink'] ?? '',
      gitHubLink: data['gitHubLink'] ?? '',
      education: data['education'] ?? [],
      achievements: data['achievements'] ?? [],
      programmingLanguages: data['programmingLanguages'] ?? [],
      hobbies: data['hobbies'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'uid': uid,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'aboutInfo': aboutInfo,
      'skills': skills,
      'experience': experience,
      'projects': projects,
      'languages': languages,
      'currentJob': currentJob,
      'twitterLink': twitterLink,
      'linkedInLink': linkedInLink,
      'gitHubLink': gitHubLink,
      'education': education,
      'achievements': achievements,
      'programmingLanguages': programmingLanguages,
      'hobbies': hobbies,
    };
    return data;
  }
}
