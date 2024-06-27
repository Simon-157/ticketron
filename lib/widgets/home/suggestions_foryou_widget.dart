import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      padding: const EdgeInsets.all(Constants.paddingSmall),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
      
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
               Radius.circular(Constants.borderRadius),
            ),
            child: CachedNetworkImage(
              imageUrl: event.images[0].url,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: Constants.paddingSmall),

          Expanded(
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: Constants.bodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Constants.paddingSmall),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Constants.secondaryTextColor),
                    const SizedBox(width: Constants.paddingSmall),
                    Text(
                      event.location,
                      style: const TextStyle(
                        color: Constants.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Constants.paddingSmall),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Constants.secondaryTextColor),
                    const SizedBox(width: Constants.paddingSmall),
                    Text(
                      '${event.date.day} ${_getMonthName(event.date.month)}',
                      style: const TextStyle(
                        color: Constants.secondaryTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                if (event.isFree)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Constants.paddingSmall,
                        horizontal: Constants.paddingMedium,
                      ),
                      decoration: BoxDecoration(
                        color:Constants.highlight,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                      ),
                      child: const Text(
                        'FREE',
                        style: TextStyle(
                          color: Constants.appTextBlue,
                        
                        ),
                      ),
                    ),
                  )
                else
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: Constants.paddingSmall,
                        horizontal: Constants.paddingMedium,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.highlight,
                        borderRadius: BorderRadius.circular(Constants.borderRadius),
                      ),
                      child: Text(
                        '\$${event.price.regularPrice}',
                        style: const TextStyle(
                          color: Constants.appTextBlue,
                         
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).scale();
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[month - 1];
  }
}
