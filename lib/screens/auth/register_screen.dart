import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _confirmObscureText = true;
  bool _isLoading = false;
  // bool _passwordVisible = false;
  bool _isOrganizer = false;

  String? _selectedCategory;
  String? _about;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    // _passwordVisible = false;
  }

  // Function to handle registration
  void _register() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Register logic based on whether user is organizer or not
      if (_isOrganizer) {
        String verificationCode = generateVerificationCode();
        await _authService
            .registerWithEmailAndPassword(
                email = email,
                password = password,
                name = name,
                "organizer",
                _selectedCategory,
                _about,
                "Accra, Ghana",
                verificationCode,
                false)
            .then((user) async {
             
          // Send verification code via email
          var res =
              await _authService.sendVerificationCode(email, verificationCode);
          if (res.containsKey('success') && res['success'] == true) {
            Navigator.pushReplacementNamed(context, '/verify', arguments: {
              'name': name,
              'email': email,
              'verificationCode': verificationCode,
            
            });
          } else {
            _showErrorDialog("Problem Verifying Account",
                "Failed to send verification code");
          }

          setState(() { 
            _isLoading = false;
          });
        }).catchError((error) {
          print(error.toString());
          _showErrorDialog(
              "Error Point", error.toString());
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        await _authService
            .registerWithEmailAndPassword(email = email, password = password,
                name = name, "user", "", "", "", "", false)
            .then((user) {
          Navigator.pushReplacementNamed(context, '/login');
        }).catchError((error) {
          _showErrorDialog(
              "Registration Failed", "Invalid email or password. Try again");
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }

  // Validation functions
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: Colors.red[300])),
          content: Text(message, style: TextStyle(color: Colors.black54)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
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
                    'Register',
                    style: Constants.heading1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Constants.paddingLarge),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    ),
                    validator: _validateName,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          CustomIcons.mail,
                          fit: BoxFit.scaleDown,
                          width: 6.0,
                          height: 6.0,
                          color: Constants.hintColor,
                        ),
                      ),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                          fit: BoxFit.scaleDown,
                          width: 6.0,
                          height: 6.0,
                          color: Constants.hintColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _obscureText
                              ? CustomIcons.eyeOff
                              : CustomIcons.eyeOpen,
                          width: 12.0,
                          height: 12.0,
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16), // Adjust vertical padding
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: _confirmObscureText,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          CustomIcons.password,
                          fit: BoxFit.scaleDown,
                          width: 6.0,
                          height: 6.0,
                          color: Constants.hintColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _confirmObscureText
                              ? CustomIcons.eyeOff
                              : CustomIcons.eyeOpen,
                          width: 12,
                          height: 12,
                          color: Constants.hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmObscureText = !_confirmObscureText;
                          });
                        },
                      ),
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16), // Adjust vertical padding
                    ),
                    validator: _validateConfirmPassword,
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  Row(
                    children: [
                      Checkbox(
                        value: _isOrganizer,
                        onChanged: (value) {
                          setState(() {
                            _isOrganizer = value ?? false;
                          });
                        },
                      ),
                      const Text('Register as Organizer'),
                    ],
                  ),
                  if (_isOrganizer)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: Constants.paddingMedium),
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                          items: const [
                            DropdownMenuItem(
                              value: 'concert',
                              child: Text('Concerts'),
                            ),
                            DropdownMenuItem(
                              value: 'theater',
                              child: Text('Theater'),
                            ),
                            DropdownMenuItem(
                              value: 'seminar',
                              child: Text('Seminar'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Select Category',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Constants.borderRadius),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16), // Adjust vertical padding
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Constants.paddingMedium),
                        TextFormField(
                          maxLines: 3,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: 'About',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Constants.borderRadius),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16), // Adjust vertical padding
                          ),
                          onChanged: (value) {
                            setState(() {
                              _about = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please provide information about your organization';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: Constants.paddingLarge),
                  ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                    ),
                    child: _isLoading?  const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                          ),
                        ) : Text('Register',
                        style: Constants.secondaryBodyText),
                  ),
                  const SizedBox(height: Constants.paddingMedium),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Already have an account? Sign In'),
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
