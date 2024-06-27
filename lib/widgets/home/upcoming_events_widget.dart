import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/event_details_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/data.dart';

class UpcomingEvents extends StatelessWidget {
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
            children:
                upcomingEvents.map((event) => EventCard(event: event)).toList(),
          ),
        ),
      ],
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: event),
          ),
        );
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: Constants.paddingMedium),
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
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
              child: CachedNetworkImage(
                imageUrl: event.images[0].url,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${event.date.day} ${_getMonthName(event.date.month)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Constants.backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Constants.borderRadius),
                  ),
                ),
                padding: const EdgeInsets.all(Constants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: Constants.bodyText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Constants.paddingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Constants.greyColor),
                          const SizedBox(width: Constants.paddingSmall),
                          Text(
                            event.location,
                            style: const TextStyle(
                              color: Constants.secondaryTextColor,
                            ),
                          ),
                        ]),
                        if (event.isFree)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(26, 0, 63, 238),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'FREE',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 63, 238),
                              
                              ),
                            ),
                          )
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                               color: Color.fromARGB(26, 0, 63, 238),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '\$${event.price.regularPrice}',
                              style: const TextStyle(
                                                              color: Color.fromARGB(255, 0, 63, 238),

                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 500.ms).scale(),
    );
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }
}
