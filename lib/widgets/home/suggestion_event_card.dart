import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/event_details_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class SuggestionCard extends StatelessWidget {
  final Event event;

  const SuggestionCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: event, role: 'user'),
          ),
        );
      },
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: event.images[0],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Icon(
                      Icons.favorite,
                      color: event.isLiked ? Colors.red : Colors.white,
                      size: 16,
                    ),
                  ),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                            event.date.day.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                            ),
                          ),
                          Text(
                            getMonthName(event.date.month),
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: Constants.paddingSmall,
                        ),
                        decoration: BoxDecoration(
                          color: Constants.highlight,
                          borderRadius:
                              BorderRadius.circular(Constants.borderRadius),
                        ),
                        child: Text(
                          event.isFree
                              ? 'FREE'
                              : '\$${event.price.regularPrice}',
                          style: const TextStyle(
                            color: Constants.appTextBlue,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 850.ms).slideY(
          begin: 0.5,
          duration: 850.ms,
          curve: Curves.easeInOutCubic,
        );
  }
}
