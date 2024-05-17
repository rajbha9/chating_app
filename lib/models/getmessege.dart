import 'package:cloud_firestore/cloud_firestore.dart';

class GetMessageData {
  String message;
  Timestamp time;
  String sender;
  String type;

  GetMessageData({
    required this.message,
    required this.time,
    required this.sender,
    required this.type,
  });
}
