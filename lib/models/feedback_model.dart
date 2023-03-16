import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class FeedBackModel {
  String? id;
  String? feedback;
  Timestamp? timestamp;

  FeedBackModel({
    @required this.feedback,
    @required this.timestamp,
    this.id
  });

  FeedBackModel.fromJson(Map map) {
    // id = map['id'];
    feedback = map['feedback'];
    timestamp = map['timestamp'];
  }

  Map<String, dynamic> toMap(){
    return {
      // "id": id,
      "feedback": feedback,
      "timestamp": timestamp,
    };
  }
}