import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_cycle_android/helpers/firestore_helper.dart';
import 'package:water_cycle_android/models/region_model.dart';
import 'package:water_cycle_android/pages/regions_page.dart';

import '../helpers/auth_helper.dart';
import '../helpers/shared_pref_helper.dart';
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
  UserCredential? _userCredential ;

  List<String> favouriteIds = List.generate(0, (index) => "");

  RegionsProvider(){
    getRegionsFromFirestore();
  }

  Future<List<String>> getFavoriteItems() async{
    favouriteIds =  await preferences.getStringList("favourite", favouriteIds);
     notifyListeners();
    return favouriteIds;
  } 
  getRegionsFromFirestore() async {
    List<RegionModel> regions =
    await FirestoreHelper.firestoreHelper.getAllRegions();
    regions.sort((a, b) =>
        favouriteIds.indexOf(a.id??"").compareTo(favouriteIds.indexOf(b.id??""))
    );
    this.regions = regions.reversed.toList();
    notifyListeners();
  }

  setStatus(RegionModel regionModel) async{
    RegionModel newRegionModel = newStatus==true ? RegionModel(
        name: regionModel.name,
        status: newStatus,
        id: regionModel.id,
        startDate: Timestamp.now(),
        endDate: regionModel.endDate,
    ):RegionModel(
      name: regionModel.name,
      status: newStatus,
      id: regionModel.id,
      endDate: Timestamp.now(),
      startDate: regionModel.startDate,
    );

    await FirestoreHelper.firestoreHelper.updateStatus(newRegionModel);
    getRegionsFromFirestore();
  }

  String cycleDuration(Timestamp startDate)  {
    DateTime startDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(startDate);
    final duration = DateTime.now().difference(startDateTime).inDays;
    if(duration == 0)
      return "منذ اقل من يوم";
    else
      return  "منذ $duration يوم ";
  }
  String durationForDisconnectedCycle(Timestamp startDate, Timestamp endDate)  {
    DateTime startDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(startDate);
    DateTime endDateTime = TimestampConverter.timestampConverter.TimeStampToDateTime(endDate);
    var fromDate = DateTime.now().difference(endDateTime).inDays;
    var lastDuration = endDateTime.difference(startDateTime).inDays;

    if(lastDuration == 0 && fromDate == 0)
      return  "مقطوعة منذ اقل من يوم , واستمرت لمدة اقل من يوم";
    else if(lastDuration == 0 && fromDate !=0)
      return  "مقطوعة منذ $fromDate يوم , واستمرت لمدة اقل من يوم";
    else
    if(fromDate == 0 && lastDuration !=0)
      return  "انقطعت قبل اقل من يوم, واستمرت لمدة $lastDuration يوم";
    else
      return  "مقطوعة منذ $fromDate يوم , واستمرت لمدة $lastDuration يوم";
    }


  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  UserCredential? get getCredentials{
    return _userCredential;
  }

  void logout(){
    _userCredential = null;
    notifyListeners();
  }

  login() async {
   _userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
   notifyListeners();
    if (_userCredential != null) {
      RouteHelper.routeHelper.goToPageWithReplacement(RegionsPage.routeName);
    }
    resetControllers();
  }

  Future saveFavouriteItem(id) async{
    favouriteIds.add(id);
    await saveFavouriteList(favouriteIds);
    getRegionsFromFirestore();
    notifyListeners();
  }

  Future deleteFavouriteItem(id) async{
    favouriteIds.remove(id);
    await saveFavouriteList(favouriteIds);
    getRegionsFromFirestore();
    notifyListeners();
  }

  Future<void> saveFavouriteList(List<String> favouriteList) async{
     await preferences.saveStringList("favourite", favouriteList);
  }


}