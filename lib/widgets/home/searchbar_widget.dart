import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/utils/constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: SvgPicture.asset(CustomIcons.search, color: Constants.accentColor, width: 20, height: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
      ),
    );
  }
}
