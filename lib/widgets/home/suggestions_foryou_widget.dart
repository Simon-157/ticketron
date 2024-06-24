import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/data.dart';

class SuggestionsForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggestions for you',
          style: Constants.heading2,
        ),
        const SizedBox(height: Constants.paddingMedium),
        Column(
          children: suggestedEvents.map((event) => SuggestionCard(event: event)).toList(),
        ),
      ],
    );
  }
}

class SuggestionCard extends StatelessWidget {
  final Event event;

  const SuggestionCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Constants.paddingMedium),
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
      child: Row(
        children: [
          SvgPicture.asset(
            event.images[0].url,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: Constants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ),
        ],
      ),
    );
  }
}
