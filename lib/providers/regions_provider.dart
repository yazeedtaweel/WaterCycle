import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_cycle_android/helpers/firestore_helper.dart';
import 'package:water_cycle_android/models/region_model.dart';

import '../services/time_helper.dart';

class RegionsProvider extends ChangeNotifier{

  TabController? tabController;
  RegionModel? region;
  List<RegionModel> regions = List.filled(1, RegionModel(name: "e", status: false));
  bool? newStatus;

  RegionsProvider(){
    getRegionsFromFirestore();
  }

  getRegionsFromFirestore() async {
    List<RegionModel> regions =
    await FirestoreHelper.firestoreHelper.getAllRegions();
    this.regions = regions;
    notifyListeners();
  }


  // Future<bool> getStatus() async{
  //   QuerySnapshot<
  // }

  setStatus(RegionModel regionModel) async{
    RegionModel newRegionModel = RegionModel(
        name: regionModel.name,
        status: newStatus,
        id: regionModel.id,
    );
    await FirestoreHelper.firestoreHelper.updateStatus(newRegionModel);
    getRegionsFromFirestore();
  }

  String cycleDuration(Timestamp start_date)  {
    DateTime start_date_time = TimestampConverter.timestampConverter.TimeStampToDateTime(start_date);
    DateTime now_date = DateTime.now();
    final duration = now_date.difference(start_date_time).inDays;
    return  "منذ "+duration.toString() +" يوم ";
  }
  String durationforDisconnectedCycle(Timestamp start_date, Timestamp end_date)  {
    DateTime start_date_time = TimestampConverter.timestampConverter.TimeStampToDateTime(start_date);
    DateTime end_date_time = TimestampConverter.timestampConverter.TimeStampToDateTime(end_date);
    DateTime now_date = DateTime.now();
    final fromDate = now_date.difference(start_date_time).inDays;
    final last_duration = end_date_time.difference(start_date_time).inDays;
    return  "منذ "+fromDate.toString() +" يوم "+", واستمرت لمدة "+last_duration.toString()+" يوم";
  }
}