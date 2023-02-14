import 'package:cloud_firestore/cloud_firestore.dart';

class TimestampConverter {
  TimestampConverter._();
  static TimestampConverter timestampConverter = TimestampConverter._();

  @override
  DateTime TimeStampToDateTime(Timestamp value) => value.toDate();

  @override
  Timestamp DateTimeToTimeStamp(DateTime value) => Timestamp.fromDate(value);
}