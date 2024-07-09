import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final int? id;
  final String message_number;
  final String? text;
  final bool isSender;
  final bool isSeen;
  List<String>? imagesList = [];
  final Timestamp timestamp;
  final bool delivered;
  final bool uploaded;

  ChatMessage(
      {this.id,
      required this.message_number,
      this.text,
      required this.isSender,
      required this.isSeen,
      this.imagesList,
      required this.timestamp,
      required this.delivered,
      required this.uploaded});

  static fromJson(Map<String, Object?> data) {}

  
}
