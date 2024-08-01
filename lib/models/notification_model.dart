import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String notificationId;
  final String userId;
  final String type;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.type,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });

  factory NotificationModel.fromFirestore(Map<String, dynamic> data, String id) {
    return NotificationModel(
      notificationId: id,
      userId: data['userId'],
      type: data['type'],
      message: data['message'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'userId': userId,
      'type': type,
      'message': message,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
