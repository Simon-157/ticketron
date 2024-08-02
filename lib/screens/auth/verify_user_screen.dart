import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class VerifyOrganizerPage extends StatefulWidget {
  final String name;
  final String email;
  final String verificationCode;

  const VerifyOrganizerPage({
    Key? key,
    required this.name,
    required this.email,
    required this.verificationCode,
  }) : super(key: key);

  @override
  _VerifyOrganizerPageState createState() => _VerifyOrganizerPageState();
}

class _VerifyOrganizerPageState extends State<VerifyOrganizerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController verificationCodeController =
      TextEditingController();
  bool _isLoading = false;
  bool _isCodeExpired = false;
  int _remainingTime = 120; // 2 minute
  Timer? _timer;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        setState(() {
          _isCodeExpired = true;
        });
        _timer?.cancel();
      }
    });
  }
  // Function to handle verification
  void _verifyCode() async {
    final formState = _formKey.currentState;
    if (formState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final enteredCode = verificationCodeController.text.trim();

      if (enteredCode.isNotEmpty) {
        try {
          // Verification successful
          final res = await _authService.verifyOrganizer(widget.email, enteredCode);

          if (res['success']) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Verification successful. You can now continue.'),
                    actions: [
                      TextButton(
                        child: const Text('Continue'),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                      ),
                    ],
                  );
                });
          } else {
            print(res['message']);
            _showErrorDialog("Verification Failed", "Invalid verification code or ${res['message']}. Please try again.");
          }
        } catch (error) {
          print(error.toString());
          _showErrorDialog("Server Error", "An error occurred while verifying the code. Please try again.");
        }
      } else {
        // Verification failed
        _showErrorDialog("Verification Failed", "Please enter a verification code.");
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  // Function to resend verification code
  void _resendCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String newVerificationCode = generateVerificationCode();
      await _authService.updateVerificationCode(widget.email, newVerificationCode);
      await _authService.sendVerificationCode(widget.email, newVerificationCode);
      _showErrorDialog("Code Sent",
          "Verification code sent successfully. Please check your email.");
      setState(() {
        _isCodeExpired = false;
        _remainingTime = 90;
        _startTimer();
      });
    } catch (error) {
      print(error.toString());
      _showErrorDialog("Server Error",
          "An error occurred while resending the code. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
                    'Verify Your Account',
                    style: Constants.heading1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  const Text(
                    'A verification code has been sent to your email. Please enter the code below to verify your account.',
                    style: Constants.bodyText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextFormField(
                    controller: verificationCodeController,
                    decoration: InputDecoration(
                      labelText: 'Verification Code',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the verification code';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  if (!_isCodeExpired)
                    Text(
                      'Code expires in $_remainingTime seconds',
                      style: Constants.captionText,
                      textAlign: TextAlign.center,
                    ),
                  if (_isCodeExpired)
                    TextButton(
                      onPressed: _resendCode,
                      child: const Text('Resend Code'),
                    ),
                  const SizedBox(height: Constants.paddingLarge),
                  ElevatedButton(
                    onPressed: _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    child:_isLoading ?  const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                          ),
                        ) : const Text('Verify',
                        style: Constants.secondaryBodyText),
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
