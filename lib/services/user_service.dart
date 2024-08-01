import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ticketron/models/user_model.dart';
import 'dart:io';

class UserService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _userCollectionRef = FirebaseFirestore.instance.collection('users');

  // Get user details
  Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot doc = await _userCollectionRef.doc(userId).get();
      if (doc.exists) {
        return UserModel.fromDocument(doc);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  // Update user details
  Future<void> updateUser(UserModel user) async {
    try {
      await _userCollectionRef.doc(user.userId).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Upload user avatar
  Future<String?> uploadAvatar(String userId, File avatar) async {
    try {
      TaskSnapshot uploadTask = await _storage.ref('avatars/$userId').putFile(avatar);
      String downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading avatar: $e');
      return null;
    }
  }

  // Update user avatar URL
  Future<void> updateAvatarUrl(String userId, String avatarUrl) async {
    try {
      await _userCollectionRef.doc(userId).update({'avatarUrl': avatarUrl});
    } catch (e) {
      print('Error updating avatar URL: $e');
    }
  }
}
