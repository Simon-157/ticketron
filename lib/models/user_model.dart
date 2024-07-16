// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String avatarUrl;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String,
    );
  }



  String toJson() => json.encode(toMap());
  
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, email: $email, avatarUrl: $avatarUrl)';
  }

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception("Document data was null");
    }

    return UserModel(
      userId: data['userId'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
      avatarUrl: data['avatarUrl'] as String,
    );
  }

}
