import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_cycle_android/models/region_model.dart';

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
}