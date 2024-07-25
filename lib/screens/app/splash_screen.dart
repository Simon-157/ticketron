import 'package:flutter/material.dart';
import 'package:ticketron/screens/organizer_screens/organizer_dashboard.dart';
import 'package:ticketron/services/auth_service.dart';
import 'dart:async';
import 'package:ticketron/utils/constants.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (_authService.getCurrentUser() != null) {
        final user = await _authService.getUserData();
        if (user != null) {
          Navigator.of(context).pushReplacementNamed('/home');
          return;
        } else {
          final organizer = await _authService.getOrganizerDetails(_authService.getCurrentUser()!.uid);
          if (organizer != null && !(organizer.isVerified as bool? ?? false)) {
            Navigator.of(context).pushReplacementNamed('/verify');
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const OrganizerDashboardScreen();
            }));
          }
        }
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Center(
        child: Text(
          'ticketron',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
