import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/home/main_event_card.dart';

class UpcomingEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming events',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingMedium),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                dummyEvents.map((event) => EventCard(event: event as Event)).toList(),
          ),
        ),
      ],
    );
  }
}
