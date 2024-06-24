import 'package:flutter/material.dart';
import 'package:ticketron/screens/app/splash_screen.dart';
import 'package:ticketron/screens/auth/login_screen.dart';
import 'package:ticketron/utils/constants.dart';

void main() {
  runApp(EventTicketingApp());
}

class EventTicketingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
        hintColor: Constants.accentColor,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            error: Constants.errorColor,
            onError: Constants.textColor,
            onPrimary: Constants.textColor,
            onSecondary: Constants.textColor,
            onSurface: Constants.textColor,
            primary: Constants.primaryColor,
            secondary: Constants.accentColor,
            surface: Constants.backgroundColor),
      ),
      home: const SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
      },
    );
  }
}
