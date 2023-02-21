import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_cycle_android/helpers/firestore_helper.dart';
import 'package:water_cycle_android/models/region_model.dart';
import 'package:water_cycle_android/pages/regions_page.dart';

import '../helpers/auth_helper.dart';
import '../services/routes_helper.dart';
import '../services/time_helper.dart';

class RegionsProvider extends ChangeNotifier{
  RegionsProvider._();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static RegionsProvider regionsProvider = RegionsProvider._();

  TabController? tabController;
  RegionModel? region;
  List<RegionModel> regions = List.filled(1, RegionModel(name: "e", status: false));
  bool? newStatus;
  bool? loggedIn = false;

  RegionsProvider(){
    getRegionsFromFirestore();
  }

  getRegionsFromFirestore() async {
    List<RegionModel> regions =
    await FirestoreHelper.firestoreHelper.getAllRegions();
    this.regions = regions;
    notifyListeners();
  }

  setStatus(RegionModel regionModel) async{
    RegionModel newRegionModel = newStatus==true ? RegionModel(
        name: regionModel.name,
        status: newStatus,
        id: regionModel.id,
        start_date: Timestamp.now(),
        end_date: regionModel.end_date,
    ):RegionModel(
      name: regionModel.name,
      status: newStatus,
      id: regionModel.id,
      end_date: Timestamp.now(),
      start_date: regionModel.start_date,
    );

    await FirestoreHelper.firestoreHelper.updateStatus(newRegionModel);
    getRegionsFromFirestore();
  }

  String cycleDuration(Timestamp startDate)  {
    DateTime startDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(startDate);
    final duration = DateTime.now().difference(startDateTime).inDays;
    return  "منذ $duration يوم ";
  }
  String durationForDisconnectedCycle(Timestamp startDate, Timestamp endDate)  {
    DateTime startDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(startDate);
    DateTime endDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(endDate);
    final fromDate = DateTime.now().difference(startDateTime).inDays;
    final lastDuration = endDateTime.difference(startDateTime).inDays;
    return  "منذ $fromDate يوم , واستمرت لمدة $lastDuration يوم";
  }


  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  login() async {
    UserCredential? userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    if (userCredential != null) {
      RouteHelper.routeHelper.goToPageWithReplacement(RegionsPage.routeName);
    }
    resetControllers();
  }
}