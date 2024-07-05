import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/data.dart';
import 'package:ticketron/widgets/home/suggestion_event_card.dart';

class SuggestionsForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggestions for you',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingMedium),
        Column(
          children: suggestedEvents.map((event) => SuggestionCard(event: event)).toList(),
        ),
      ],
    );
  }
}
