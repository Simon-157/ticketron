import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/event_details_screen.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class EventCard extends StatefulWidget {
  final Event event;

  EventCard({required this.event});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  EventService eventService = EventService();
  AuthService authService = AuthService();

  Future<void> _deleteEvent() async {
    try {
      await eventService.deleteEvent(widget.event.eventId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.event.title} deleted successfully!'),
        ),
      );
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      await eventService.toggleFavoriteEvent(authService.getCurrentUser()!.uid, widget.event.eventId);
      setState(() {
        widget.event.isLiked = !widget.event.isLiked;
      });
    } catch (e) {

      print('Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(event: widget.event, role: 'user'),
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
                imageUrl: widget.event.images[0],
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
              top: 4,
              left: 4,
              child: IconButton(
                icon: const Icon(Icons.favorite, size: 20,),
                color: widget.event.isLiked ?  Colors.red : Colors.white,
                
                onPressed: () {  
                  _toggleFavorite();

                },
              )),
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
                  '${widget.event.date.day} ${getMonthName(widget.event.date.month)}',
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
                      widget.event.title,
                      style: Constants.bodyText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Constants.paddingSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Constants.greyColor,
                              ),
                              const SizedBox(width: Constants.paddingSmall),
                              Expanded(
                                child: Text(
                                  widget.event.location,
                                  style: const TextStyle(
                                    color: Constants.secondaryTextColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (widget.event.isFree)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(26, 0, 63, 238),
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
                              color: const Color.fromARGB(26, 0, 63, 238),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '\$${widget.event.price.regularPrice}',
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
}

class EventSkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            5,
            (index) => Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: SkeletonLoader(
                    builder: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: 1,
                    period: const Duration(seconds: 2),
                    highlightColor: Colors.grey[100]!,
                    baseColor: Colors.grey[300]!,
                  ),
                )),
      ),
    );
  }
}
