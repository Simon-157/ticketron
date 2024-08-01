import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticketron/screens/app/splash_screen.dart';
import 'package:ticketron/screens/auth/login_screen.dart';
import 'package:ticketron/screens/auth/register_screen.dart';
import 'package:ticketron/screens/auth/verify_user_screen.dart';
import 'package:ticketron/screens/event/order_complete.dart';
import 'package:ticketron/services/notification_service.dart';
import 'package:ticketron/shared/page_navigation.dart';
import 'package:ticketron/utils/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  runApp(const TicketronApp());
}

class TicketronApp extends StatelessWidget {
  const TicketronApp({super.key});

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
      // home: const (),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const RegisterPage(),
        '/verify': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

          if (args != null) {
            return VerifyOrganizerPage(
              name: args['name']!,
              email: args['email']!,
              verificationCode: args['verificationCode']!,
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Invalid Route'),
              ),
            );
          }
        },
        '/home': (context) => const PageNavigation(),
        '/event': (context) => const PageNavigation(),
        '/explore': (context) => const PageNavigation(),
        '/payment/success': (context) => const OrderCompleteScreen(),
      },
    );
  }
}
