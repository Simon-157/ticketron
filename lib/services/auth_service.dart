import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Sign in with email & password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<Object?> registerWithEmailAndPassword(
      String email,
      String password,
      String name,
      String role,
      String? category,
      String? about,
      String? address,
      String? varificationCode,
      bool isVerified) async {
    if (role == "user") {
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User? user = result.user;

        await _firestore.collection('users').doc(user?.uid).set({
          'user_id': user?.uid,
          'name': name,
          'email': email,
          'isVerified': false,
          'avatarUrl':
              'https://avatar.iran.liara.run/username?username=[${name}+${email}]',
          'role': 'user',
          'address': 'Accra, Ghana',
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user;
      } catch (error) {
        print(error.toString());
        return error.toString() == '[firebase_auth/email-already-in-use]'
            ? 'Email already in use'
            : 'Something went wrong';
      }
    } else if (role == "organizer") {
      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User? user = result.user;

        await _firestore.collection('organizers').doc(user?.uid).set({
          'organizerId': user?.uid,
          'name': name,
          'email': email,
          'isVerified': false,
          'logoUrl':
              'https://avatar.iran.liara.run/username?username=[${name}+${email}]',
          'category': category,
          'about': about,
          'verificationCode': varificationCode,
        });

        return user;
      } catch (error) {
        print(error.toString());
        return error.toString() == '[firebase_auth/email-already-in-use]'
            ? 'Email already in use'
            : 'Something went wrong';
      }
    }
    return null;
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user?.uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(user?.uid).set({
          'user_id': user?.uid,
          'name': user?.displayName,
          'email': user?.email,
          'avatarUrl': user?.photoURL,
          'role': 'user',
          'address': 'Accra, Ghana',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      // if user exists and userToken is not in user doc, update user with userToken
      else if (userDoc.exists && userDoc.data() == null) {
        await _firestore.collection('users').doc(user?.uid).update({
          'userToken': user?.uid,
        });
      }
      print('User: $user');
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future<void> updateUserToken(String userToken) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        throw Exception('User is null');
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      // Check if the document exists and if it has a userToken field
      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>?;
        if (data != null &&
            data.containsKey('userToken') &&
            data['userToken'] != null) {
          return;
        }
      }

      await _firestore.collection('users').doc(user.uid).update({
        'userToken': userToken,
      });
    } catch (error) {
      print('Error updating user token: $error');
    }
  }

  // Sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Update user profile
  Future<void> updateProfile(String name) async {
    try {
      User? user = _auth.currentUser;
      await user?.updateProfile(displayName: name);
      await user?.reload();
      user = _auth.currentUser;

      // Update Firestore user document
      await _firestore.collection('users').doc(user?.uid).update({
        'name': name,
      });
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Get current user
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Fetch user data from Firestore
  Future<UserModel> getUserData() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(getCurrentUser()?.uid).get();
      return UserModel.fromDocument(snapshot);
    } catch (error) {
      print(error.toString());
      throw Exception("Error fetching user data from Firestore");
    }
  }

  Future<dynamic> sendVerificationCode(
      String email, String verificationCode) async {
    final response = await http.post(
      Uri.parse('https://connectoapi.onrender.com/verify'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'verificationCode': verificationCode,
      }),
    );

    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send verification code');
    }
  }

  Future<Map<String, dynamic>> verifyOrganizer(
      String email, String verificationCode) async {
    try {
      final querySnapshot = await _firestore
          .collection('organizers')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isEmpty) {
        print("Organizer not found");
        return {'success': false, 'message': 'Organizer not found'};
      }
      final organizerId = querySnapshot.docs.first.id;
      final organizerData =
          await _firestore.collection('organizers').doc(organizerId).get();

      final data = organizerData.data() as Map<String, dynamic>;
      if (data['verificationCode'] == verificationCode) {
        await _firestore.collection('organizers').doc(organizerId).update({
          'isVerified': true,
        });
        return {'success': true, 'message': 'Organizer verified successfully'};
      }
      return {
        'success': false,
        'message': 'Invalid verification code. Please try again.'
      };
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to verify organizer');
    }
  }

  Future<Map<String, dynamic>> updateVerificationCode(
      String email, String newVerificationCode) async {
    try {
      final querySnapshot = await _firestore
          .collection('organizers')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final organizerId = querySnapshot.docs.first.id;
        await _firestore.collection('organizers').doc(organizerId).update({
          'verificationCode': newVerificationCode,
        });
        return {
          'success': true,
          'message': 'Verification code updated successfully'
        };
      } else {
        return {'success': false, 'message': 'Organizer User not found'};
      }
    } catch (error) {
      print(error.toString());
      throw Exception('Failed to update verification code');
    }
  }

  Future<Organizer> getOrganizerDetails(String uid) async {
    final snapshot = await _firestore.collection('organizers').doc(uid).get();
    if (!snapshot.exists) {
      throw Exception('Organizer not found');
    }
    return Organizer.fromDocument(snapshot);
  }
}
