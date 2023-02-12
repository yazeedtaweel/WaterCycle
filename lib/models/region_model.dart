import 'package:flutter/cupertino.dart';
class RegionModel {
  String? id;
  String? name;
  bool? status = false;

  RegionModel({
    @required this.name,
    @required this.status,
    this.id
  });

  RegionModel.fromJson(Map map) {
    id = map['id'];
    name = map['name'];
    status = map['status'];
  }

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "status": status
    };
  }
}