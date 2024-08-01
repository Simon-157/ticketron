// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Organizer {
  final String organizerId;
  final String name;
  final String email;
  final bool isVerified;
  final String logoUrl;
  final String category;
  final String about;
  final String? verificationCode;
  final String phoneNumber;

  Organizer(
    
    { required this.organizerId,
    required this.email,
    required this.name,
    required this.isVerified,
    required this.logoUrl,
    required this.category,
    required this.about,
    required this.verificationCode, required this.phoneNumber}
  );



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'organizerId': organizerId,
      'name': name,
      'isVerified': isVerified,
      'logoUrl': logoUrl,
      'category': category,
      'about': about,
      'verificationCode': verificationCode,
      'phoneNumber': phoneNumber
    };
  }

  factory Organizer.fromMap(Map<String, dynamic> map) {
    return Organizer(
      organizerId: map['organizerId'] ??  '',
      name: map['name'] ?? ' ',
      isVerified: map['isVerified'] as bool,
      logoUrl: map['logoUrl'] ?? ' ',
      category: map['category'] ?? ' ',
      about: map['about'] ?? ' ',
      verificationCode: map['verificationCode'] ?? ' ',
      email: map['email'] ?? ' ',
      phoneNumber: map['phoneNumber'] ?? '233000000000',
    );
  }

  String toJson() => json.encode(toMap());

  factory Organizer.fromJson(String source) => Organizer.fromMap(json.decode(source) as Map<String, dynamic>);

  static Organizer fromDocument(DocumentSnapshot<Map<String, dynamic>> value) {
    return Organizer.fromMap(value.data()!);
  }

}
