import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:portfolio_app/models/cv_model.dart';
import 'package:portfolio_app/models/user.dart';

class FirestoreMethods {
  var userCollection = FirebaseFirestore.instance.collection('users');
  var portfolioCollection = FirebaseFirestore.instance.collection('portfolios');

  String uid = FirebaseAuth.instance.currentUser == null
      ? ''
      : FirebaseAuth.instance.currentUser!.uid;

  Future<void> uploadUserData(UserModel user) async {
    await userCollection.doc(user.uid).set(
      {'uid': user.uid, 'isAdmin': user.isAdmin},
    );
  }

  Future<void> editCv(Map<String, dynamic> data) async {
    await portfolioCollection.doc(uid).set(data, SetOptions(merge: true));
  }

  Future<CvModel> getCv() async {
    var ds = await portfolioCollection.doc(uid).get();
    return CvModel.fromSnap(ds);
  }
}
