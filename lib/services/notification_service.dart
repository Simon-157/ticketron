import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketron/models/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ticketron/services/auth_service.dart';

class NotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // Initialize local notifications
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, );

    // Request notification permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Get FCM token and update it in the auth service
    final String? token = await _firebaseMessaging.getToken();
    print('FCM token: $token');
    if (token != null) {
      await _authService.updateUserToken(token);
    }

    // Handle foreground and background messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpened);
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }

  // Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    await _showNotification(message);
  }

  // Handle notification opened
  Future<void> _handleNotificationOpened(RemoteMessage message) async {
    // Navigate to the appropriate screen or handle notification data
    // Example: Navigate to a specific screen
    // Navigator.pushNamed(context, '/notification', arguments: message.data);
  }

  // Handle background messages
  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    await _showNotification(message);
  }

  // Display a local notification
  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Ticketron Notification', 
      'Ticketron', 
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      message.messageId.hashCode, 
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data.toString(),
    );
  }

  // Handle notification taps
  Future<void> _onSelectNotification(String? payload) async {
    // Handle navigation or other actions based on the payload
    // Example: Navigate to a specific screen
    // Navigator.pushNamed(context, '/notification', arguments: payload);
  }

  // Stream of notifications for a user
  Stream<List<NotificationModel>> getNotificationsByUserId(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // Mark a notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isRead': true,
    });
  }

  // Create a new notification
  Future<void> createNotification(NotificationModel notification) async {
    await _firestore.collection('notifications').add(notification.toMap());
  }
}
