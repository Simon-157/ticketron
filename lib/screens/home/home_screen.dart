import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/filter_toggles_widget.dart';
import 'package:ticketron/widgets/home/searchbar_widget.dart';
import 'package:ticketron/widgets/home/suggestions_foryou_widget.dart';
import 'package:ticketron/widgets/home/upcoming_events_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find events near you',
                style: TextStyle(
                  color: Color.fromARGB(90, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'California, USA',
                    style: Constants.heading3,
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Color.fromARGB(57, 0, 0, 0)),
                        onPressed: () {
                          // Logic for notification button
                        },
                      ),
                      Positioned(
                        right: 15,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(169, 247, 59, 1),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Constants.paddingMedium),
                const SearchBox(),
                const SizedBox(height: Constants.paddingMedium),
                const FilterToggles(),
                const SizedBox(height: Constants.paddingMedium),
                UpcomingEvents(),
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
