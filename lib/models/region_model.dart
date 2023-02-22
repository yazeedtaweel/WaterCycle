import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class RegionModel {
  String? id;
  String? name;
  bool? status = false;
  Timestamp? startDate;
  Timestamp? endDate;

  RegionModel({
    @required this.name,
    @required this.status,
    @required this.startDate,
    @required this.endDate,
    this.id
  });

  RegionModel.fromJson(Map map) {
    id = map['id'];
    name = map['name'];
    status = map['status'];
    startDate = map['start_date'];
    endDate = map['end_date'];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "status": status,
      "start_date": startDate,
      "end_date": endDate,
    };
  }
}