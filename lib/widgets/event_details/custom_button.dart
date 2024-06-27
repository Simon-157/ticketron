import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
