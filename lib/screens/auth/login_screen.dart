import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0), 
                        child: SvgPicture.asset(
                          CustomIcons.mail,
                          width: 12,
                          height: 12,
                          color: Constants.hintColor,
                        ),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          CustomIcons.password,
                          width: 12,
                          height: 12,
                          color: Constants.hintColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _obscureText ? CustomIcons.eyeOff : CustomIcons.eyeOpen,
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
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
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
                  const SizedBox(height: Constants.paddingLarge),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Handle sign in
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    child: const Text('Sign In', style: Constants.secondaryBodyText),
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
                      // Handle sign in with Google
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Constants.textColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        side: const BorderSide(color: Constants.borderColor),
                      ),
                    ),
                    icon: SvgPicture.asset(CustomIcons.google, width: 24, height: 24),
                    label: const Text('Sign In with Google'),
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Handle sign in with Apple
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Constants.textColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                        side: const BorderSide(color: Constants.borderColor),
                      ),
                    ),
                    icon: SvgPicture.asset(CustomIcons.apple, width: 24, height: 24),
                    label: const Text('Sign In with Apple'),
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign up page
                    },
                    child: const Text('Create an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
