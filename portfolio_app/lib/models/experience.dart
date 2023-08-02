import 'package:cloud_firestore/cloud_firestore.dart';

class ExperienceModel {
  final Timestamp dateStarted;
  final Timestamp dateFinished;
  final String title;
  final String description;

  ExperienceModel({
    required this.dateStarted,
    required this.dateFinished,
    required this.title,
    required this.description,
  });

  factory ExperienceModel.fromSnap(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    return ExperienceModel(
      dateStarted: data['dateStarted'],
      dateFinished: data['dateFinished'],
      title: data['title'],
      description: data['description'],
    );
  }

  factory ExperienceModel.fromJson(Map<String, dynamic> data) {
    return ExperienceModel(
      dateStarted: data['dateStarted'],
      dateFinished: data['dateFinished'],
      title: data['title'],
      description: data['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateStarted': dateStarted,
      'dateFinished': dateFinished,
      'title': title,
      'description': description,
    };
  }
}
