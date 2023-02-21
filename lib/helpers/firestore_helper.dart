import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_cycle_android/models/region_model.dart';

import '../models/admin_model.dart';

class FirestoreHelper{
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreStream() {
    return firebaseFirestore
        .collection('regions')
        .snapshots();
  }

  addRegionsToFirestore(Map map) async {
    firebaseFirestore
        .collection('regions')
        .add({...map});
  }

  Future<List<RegionModel>> getAllRegions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await firebaseFirestore.collection('regions').get();
    List<RegionModel> regions = querySnapshot.docs.map((e) {
      return RegionModel.fromJson(e.data());
    }).toList();
    return regions;
  }
  updateStatus(RegionModel regionModel) async {
    await firebaseFirestore
        .collection('regions')
        .doc(regionModel.id)
        .update(regionModel.toMap());
  }


  // Future<LoginUser> getUserFromFirestore(String userId) async {
  //   // firebaseFirestore.collection('Users').where('id', isEqualTo: userId).get();
  //   DocumentSnapshot documentSnapshot =
  //   await firebaseFirestore.collection('Users').doc(userId).get();
  //   // CustomDialog.customDialog
  //   //     .showCustomDialog(documentSnapshot.data.toString());
  //   return LoginUser.fromMap(documentSnapshot.data());
  // }

  // private fun signIn(email: String, password: String) {
  // // [START sign_in_with_email]
  // auth.signInWithEmailAndPassword(email, password)
  //     .addOnCompleteListener(this) { task ->
  // if (task.isSuccessful) {
  // // Sign in success, update UI with the signed-in user's information
  // Log.d(TAG, "signInWithEmail:success")
  // val user = auth.currentUser
  // updateUI(user)
  // } else {
  // // If sign in fails, display a message to the user.
  // Log.w(TAG, "signInWithEmail:failure", task.exception)
  // Toast.makeText(baseContext, "Authentication failed.",
  // Toast.LENGTH_SHORT).show()
  // updateUI(null)
  // }
  // }
  // // [END sign_in_with_email]
  // }
}