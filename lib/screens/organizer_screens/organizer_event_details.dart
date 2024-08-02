import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/live_event.dart';
import 'package:ticketron/screens/organizer_screens/attendance_screen.dart';
import 'package:ticketron/screens/organizer_screens/edit_event_screen.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';
import 'package:ticketron/widgets/event_details/event_location_widget.dart';

class OrganizerEventDetails extends StatelessWidget {
  final Event event;

  const OrganizerEventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Logic for additional options (e.g., sharing, editing)
            },
            icon: SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal:Constants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventImageSection(event: event),
            const SizedBox(height: Constants.paddingMedium),
            EventInfoSection(event: event),
            const SizedBox(height: Constants.paddingMedium),
            EventStatisticsSection(event: event),
            const SizedBox(height: Constants.paddingMedium),
            EventLocationSection(location: event.location, latitude:5.7603 , longitude: 0.2199, ),

            const SizedBox(height: Constants.paddingMedium),
          ],
        ),
      ),
        bottomNavigationBar:  ActionSection(event: event),
    );
  }
}

class EventImageSection extends StatelessWidget {
  final Event event;

  const EventImageSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: CachedNetworkImage(
        imageUrl: event.images.isNotEmpty
            ? event.images[0]
            : "https://avatars.githubusercontent.com/u/79936608?v=4",
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}

class EventInfoSection extends StatelessWidget {
  final Event event;

  const EventInfoSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: Constants.heading2,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            children: [
              const SizedBox(width: Constants.paddingSmall),
              const Icon(Icons.calendar_today,
                  size: 16, color: Constants.greyColor),
              const SizedBox(width: Constants.paddingSmall),
              Text(
                '${event.date.day} ${getMonthName(event.date.month)} ${event.date.year}',
                style: Constants.bodyText,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time,
                  size: 16, color: Constants.greyColor),
              const SizedBox(width: Constants.paddingSmall),
              Text(
                event.time,
                style: Constants.bodyText,
              ),
            ],
          ),
        ])
      ],
    );
  }
}

class EventStatisticsSection extends StatefulWidget {
  final Event event;

  const EventStatisticsSection({super.key, required this.event});

  @override
  _EventStatisticsSectionState createState() => _EventStatisticsSectionState();
}

class _EventStatisticsSectionState extends State<EventStatisticsSection> {
  Map<String, dynamic>? statistics;
  EventService eventsService = EventService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStatistics();
  }

  Future<void> fetchStatistics() async {
    try {
      final data = await eventsService.getEventStatistics(widget.event.eventId);
      print("data: $data");
      setState(() {
        statistics = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load statistics: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistics',
          style: Constants.bodyText.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Constants.paddingSmall),
        isLoading
            ? CircularProgressIndicator()
            : statistics == null
                ? Container()
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        StatCard(
                          title: 'Total Revenue',
                          value:
                              '\$${statistics!['totalRevenue'].toStringAsFixed(2)}',
                        ),
                        StatCard(
                          title: 'Sold Tickets',
                          value: statistics!['soldTickets'].toString(),
                        ),
                        StatCard(
                          title: 'Canceled Tickets',
                          value: statistics!['canceledTickets'].toString(),
                        ),
                      ],
                    ),
                  ),
      ],
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({Key? key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      // margin: const EdgeInsets.only(bottom: Constants.paddingSmall),
      child: Container(
        // width: 140,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(Constants.paddingSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Constants.bodyText,
              ),
              const SizedBox(height: Constants.paddingSmall),
              Text(
                value,
                style: Constants.bodyText.copyWith(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ActionSection extends StatelessWidget {
  final Event event;


  const ActionSection({super.key, required this.event, });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:Constants.paddingMedium),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventEditScreen(event: event, ),
                ),
              );
            },
            child: const Text('Edit Event')
          ) ,
          const SizedBox(width: Constants.marginSmall),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveStreamScreen(event: event, isHost: true),
                ),
              );
            }, 
            child: const Text('Go Live'),
          
          ),
                    const SizedBox(width: Constants.marginSmall),

          ElevatedButton(
            onPressed: () {
              print(event.eventId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceScreen(eventId:event.eventId),
                ),
              );
            },
            child:  const Text('Attendance') 
          ),
        ],
      ),
    );
  }
}