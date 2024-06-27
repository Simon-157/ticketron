import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/utils/constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: Constants.bodyText.copyWith(color: Constants.greyColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            CustomIcons.search,
            color: Constants.hintColor,
            width: 20, 
            height: 20, 
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(22, 136, 134, 134),
        contentPadding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
      ),
    );
  }
}
