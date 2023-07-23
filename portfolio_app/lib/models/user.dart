import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final bool isAdmin;

  UserModel({required this.uid, required this.isAdmin});

  factory UserModel.fromSnap(DocumentSnapshot ds) {
    Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
    return UserModel(uid: data['uid'], isAdmin: data['isAdmin']);
  }
}
