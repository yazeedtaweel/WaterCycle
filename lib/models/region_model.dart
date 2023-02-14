import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class RegionModel {
  String? id;
  String? name;
  bool? status = false;
  Timestamp? start_date;
  Timestamp? end_date;

  RegionModel({
    @required this.name,
    @required this.status,
    this.id
  });

  RegionModel.fromJson(Map map) {
    id = map['id'];
    name = map['name'];
    status = map['status'];
    start_date = map['start_date'];
    end_date = map['end_date'];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "status": status,
      "start_date": start_date,
      "end_date": end_date,
    };
  }
}