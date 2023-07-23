import 'package:cloud_firestore/cloud_firestore.dart';

class CvModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String aboutInfo;
  final List skills;
  final List experience;
  final List projects;
  final List languages;

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
    };
    return data;
  }
}
