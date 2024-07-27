import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/main_event_card.dart';

class UpcomingEvents extends StatefulWidget {
  final List<Event> events;

  const UpcomingEvents({super.key, required this.events});

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
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
                widget.events.map((event) => EventCard(event: event as Event)).toList(),
          ),
        ),
      ],
    );
  }
}
