import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/filter_toggles_widget.dart';
import 'package:ticketron/widgets/home/suggestions_foryou_widget.dart';
import 'package:ticketron/widgets/home/upcoming_events_widget.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find events near',
                  style: Constants.heading2,
                ),
                const Text(
                  'California, USA',
                  style: Constants.heading1,
                ),
                const SizedBox(height: Constants.paddingMedium),
                const SearchBar(),
                const SizedBox(height: Constants.paddingMedium),
                const FilterToggles(),
                const SizedBox(height: Constants.paddingMedium),
                const UpcomingEvents(),
                const SizedBox(height: Constants.paddingLarge),
                SuggestionsForYou(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
