import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_cycle_android/helpers/firestore_helper.dart';
import 'package:water_cycle_android/models/region_model.dart';

class RegionsProvider extends ChangeNotifier{

  TabController? tabController;
  RegionModel? region;
  List<RegionModel> regions = List.filled(1, RegionModel(name: "e", status: false));

  RegionsProvider(){
    getRegionsFromFirestore();
  }

  getRegionsFromFirestore() async {
    List<RegionModel> regions =
    await FirestoreHelper.firestoreHelper.getAllRegions();
    this.regions = regions;
    notifyListeners();
  }
}