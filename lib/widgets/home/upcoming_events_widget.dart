import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/data.dart';


class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming events',
          style: Constants.heading2,
        ),
        const SizedBox(height: Constants.paddingMedium),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: upcomingEvents.map((event) => EventCard(event: event)).toList(),
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: Constants.paddingMedium),
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            event.images[0].url,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            '${event.date.month}/${event.date.day}',
            style: Constants.heading2,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            event.title,
            style: Constants.bodyText,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            event.location,
            style: Constants.secondaryBodyText,
          ),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            event.time,
            style: Constants.secondaryBodyText,
          ),
          if (event.isFree)
            const Text(
              'FREE',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            Text(
              '\$${event.price.regularPrice}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
