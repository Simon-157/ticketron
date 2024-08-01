import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/main_event_card.dart';

class UserFavoritesScreen extends StatefulWidget {
  const UserFavoritesScreen({super.key});

  @override
  _UserFavoritesScreenState createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  EventService eventService = EventService();
  AuthService authService = AuthService();

  List<Event> favoriteEvents = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    eventService = EventService();
    _fetchFavoriteEvents();
  }

  Future<void> _fetchFavoriteEvents() async {
    try {
      List<Event> events = await eventService
          .getFavoritedEvents(authService.getCurrentUser()!.uid);
      setState(() {
        favoriteEvents = events;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching favorite events: $e');
      setState(() {
        errorMessage = 'Failed to load favorite events';
        isLoading = false;
      });
    }
  }

  Future<void> _refreshFavoriteEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    await _fetchFavoriteEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Constants.backgroundColor,
        title: const Text('My Favorites'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage))
                  : favoriteEvents.isEmpty
                      ? const Center(child: Text('You have no favorites'))
                      : RefreshIndicator(
                          onRefresh: _refreshFavoriteEvents,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: favoriteEvents.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              final event = favoriteEvents[index];
                              return EventCard(event: event);
                            },
                          ),
                        ),
        ),
      ),
    );
  }
}
