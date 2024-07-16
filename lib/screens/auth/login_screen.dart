import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/screens/auth/verify_user_screen.dart';
import 'package:ticketron/screens/organizer_screens/organizer_dashboard.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;
  // bool _passwordVisible = false;
  bool _isOrganizer = false;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // _passwordVisible = false;
  }

  // Function to handle email/password login
  void _signInWithEmailAndPassword() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      User? user =
          await _authService.signInWithEmailAndPassword(email, password);

      setState(() {
        _isLoading = false;
      });

      if (user != null && !_isOrganizer) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (user != null && _isOrganizer) {
        // GET ORGANIZER DETAILS TO SEE IF HE IS VERIFIED; IF NOT GO TO VERIFY SCREEN
        Organizer organizer = await _authService.getOrganizerDetails(user.uid);
        if (!organizer.isVerified) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VerifyOrganizerPage(
              name: organizer.name,
              email: organizer.email,
              verificationCode: organizer.verificationCode!,
            );
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return OrganizerDashboardScreen();
          }));
        }
      } else {
        _showErrorDialog(
            "Login Failed", "Invalid email or password. Please try again.");
      }
    } else {
      _showErrorDialog("Login Failed", "Please enter your email and password.");
    }
  }

  // Function to handle Google sign-in
  void _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    User? user = await _authService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showErrorDialog(
          "Login Failed", "Failed to sign in with Google. Please try again.");
    }
  }

  void _signInWithApple() {
    _showErrorDialog("Login Failed",
        "Facebook sign-in is not supported yet., Try Google or Email instead.");
  }

  // Function to show error dialog
  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.red[300])),
          content: Text(message, style: const TextStyle(color: Colors.black54)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Basic email regex pattern
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Constants.paddingLarge),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome back',
                    style: Constants.heading1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          CustomIcons.mail,
                          fit: BoxFit.scaleDown,
                          width: 8.0,
                          height: 8.0,
                          color: Constants.hintColor,
                        ),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          CustomIcons.password,
                          fit: BoxFit.scaleDown,
                          width: 8.0,
                          height: 8.0,
                          color: Constants.hintColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _obscureText
                              ? CustomIcons.eyeOff
                              : CustomIcons.eyeOpen,
                          width: 12,
                          height: 12,
                          color: Constants.hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Constants.primaryColor,
                        checkColor: Colors.white,
                        
                        value: _isOrganizer,
                        onChanged: (bool? value) {
                          setState(() {
                            _isOrganizer = value ?? false;
                          });
                        },
                      ),
                      const Text('Sign in as organizer'),
                    ],
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _signInWithEmailAndPassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                          ),
                        )
                      : const Text('Sign In', style: Constants.secondaryBodyText),
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  const Text(
                    'Or',
                    style: Constants.captionText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  ElevatedButton.icon(
                    onPressed: () {
                      _signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Constants.textColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                        side: const BorderSide(color: Constants.borderColor),
                      ),
                    ),
                    icon: SvgPicture.asset(CustomIcons.google,
                        width: 24, height: 24),
                    label: const Text('Sign In with Google'),
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  ElevatedButton.icon(
                    onPressed: () {
                      _signInWithApple();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Constants.textColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                        side: const BorderSide(color: Constants.borderColor),
                      ),
                    ),
                    icon: SvgPicture.asset(CustomIcons.apple,
                        width: 24, height: 24),
                    label: const Text('Sign In with Apple'),
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up page
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text('Create an account'),
                  ),
                  // if (_isLoading)
                  //   Container(
                  //     color: Colors.black54.withOpacity(0.6),
                  //     child: const Center(
                  //       child: CircularProgressIndicator(),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
