import 'package:cloud_firestore/cloud_firestore.dart';

class SkillModel {
  final String skill;
  final String yearsOfExperience;

  SkillModel({required this.skill, required this.yearsOfExperience});

  
  factory SkillModel.fromSnap(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    return SkillModel(
      skill: data['skill'],
      yearsOfExperience: data['yearsOfExperience'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'skill': skill,
      'yearsOfExperience': yearsOfExperience,
    };
    return data;
  }
}
