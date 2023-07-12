import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio_app/models/user.dart';

class FirestoreMethods {
  var userCollection = FirebaseFirestore.instance.collection('users');
  var portfolioCollection = FirebaseFirestore.instance.collection('portfolios');

  Future<void> uploadUserData(UserModel user) async {
    await userCollection.doc(user.uid).set(
      {'uid': user.uid, 'isAdmin': user.isAdmin},
    );
  }
}
