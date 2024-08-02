import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/widgets/organizer_view_widgets/organizer_bottom_nav.dart';
import 'package:ticketron/widgets/organizer_view_widgets/organizer_event_card.dart';

class OrganizerDashboardScreen extends StatefulWidget {
  const OrganizerDashboardScreen({super.key});

  @override
  State<OrganizerDashboardScreen> createState() => _OrganizerDashboardScreenState();
}

class _OrganizerDashboardScreenState extends State<OrganizerDashboardScreen> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final EventService _eventService = EventService();
  final Map<String, dynamic> _organizerStatistics = {};

  Organizer? organizer;
  List<Event> events = [];
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _authService.getOrganizerDetails(_authService.getCurrentUser()!.uid).then((value) {
      setState(() {
        organizer = value;
      });
      _fetchEvents();
      _populateOrganizerStatistics();
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  Future<void> _fetchEvents() async {
    if (organizer != null) {
      try {
        print('Fetching events for organizer: ${organizer!.organizerId}');
        List<Event> fetchedEvents = await _eventService.getAllEvents(organizer!.organizerId);
        setState(() {
          events = fetchedEvents;
          isLoading = false;
        });

        print('Fetched events: $events');
      } catch (e) {
        print('Failed to load events: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _populateOrganizerStatistics() async {
    if (organizer != null) {
      try {
        Map<String, dynamic> statistics = await _eventService.getOrganizerStatistics(organizer!.organizerId);
        setState(() {
          _organizerStatistics.addAll(statistics);
        });
      } catch (e) {
        print('Failed to load statistics: $e');
      }
    }
  }

  Widget _buildSkeletonLoader() {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Number of skeleton items
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            width: 150.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
              final Offset tapPosition = overlay.localToGlobal(Offset.zero);
              _showPopupMenu(context, tapPosition);
            },
            child: CircleAvatar(
              radius: 10.0,
              backgroundImage: NetworkImage(organizer?.logoUrl ?? 'https://via.placeholder.com/150', scale: 0.1),
            ),
          ),
        ),
        title: Text("${organizer?.name}'s Dashboard", style: const TextStyle(fontSize: 18.0)),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                tooltip: 'Notifications',
                icon: const Icon(Icons.notifications, color: Colors.blueAccent),
                onPressed: () {
                  // notification handling
                },
              ),
              Positioned(
                top: 12,
                right: 17,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Current Events',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            isLoading ? _buildSkeletonLoader() : Container(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Event event = events[index];
                  return buildEventCard(event);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildStatisticCard(
                    context,
                    title: 'Present',
                    count: events.where((event) => event.date.isAfter(DateTime.now())).length.toDouble(),
                  ),
                  const SizedBox(width: 16.0),
                  _buildStatisticCard(
                    context,
                    title: 'Past',
                    count: events.where((event) => event.date.isBefore(DateTime.now())).length.toDouble(),
                  ),
                  const SizedBox(width: 16.0),
                  _buildStatisticCard(
                    context,
                    title: 'Audience',
                    count: _organizerStatistics['totalSoldTickets']?.toDouble() ?? 0.0,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Revenue Streams',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildStatisticCard(
                    context,
                    title: 'Revenue',
                    count: _organizerStatistics['totalRevenue']?.toDouble() ?? 0.0,
                  ),
                  const SizedBox(width: 16.0),
                  _buildStatisticCard(
                    context,
                    title: 'Events',
                    count: _organizerStatistics['totalEvents']?.toDouble() ?? 0.0,
                  ),
                  const SizedBox(width: 16.0),
                  _buildStatisticCard(
                    context,
                    title: 'Highest',
                    count: _organizerStatistics['bestTicketQuantity']?.toDouble() ?? 0.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: OrganizerBottomNav(organizer: organizer, currentIndex: 0),
    );
  }

  Widget buildEventCard(Event event) {
    return OrganizerEventCard(event: event);
  }

  Widget _buildStatisticCard(context, {required String title, required double count}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 85.0,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$count',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset tapPosition) {
    _controller.forward();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy + 70,
        0,
        0,
      ),
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: <Widget>[
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 10),
              Text('Edit Profile'),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'signout',
          child: Row(
            children: <Widget>[
              Icon(Icons.exit_to_app, color: Colors.red),
              SizedBox(width: 10),
              Text('Sign Out'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _controller.reverse();
        if (value == 'logout') {
          _authService.signOut(context);
        }

      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
}
