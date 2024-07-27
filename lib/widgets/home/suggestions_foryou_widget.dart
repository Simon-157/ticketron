import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/suggestion_event_card.dart';

class SuggestionsForYou extends StatefulWidget {
  const SuggestionsForYou({super.key});

  @override
  _SuggestionsForYouState createState() => _SuggestionsForYouState();
}

class _SuggestionsForYouState extends State<SuggestionsForYou> {
  late EventService eventService;
  AuthService authService = AuthService();
  List<Event> suggestedEvents = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    eventService = EventService();
    _fetchSuggestedEvents();
  }

  Future<void> _fetchSuggestedEvents() async {
    String? uid = authService.getCurrentUser()?.uid;

    if (uid == null) {
      setState(() {
        errorMessage = 'User not logged in';
        isLoading = false;
      });
      return;
    }

    try {
      List<Event> events = await eventService.getEventsSuggestions(uid);
      setState(() {
        suggestedEvents = events;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        errorMessage = 'No suggestions found';
        isLoading = false;
      });
    }
  }

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
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : Column(
                    children: suggestedEvents
                        .map((event) => SuggestionCard(event: event))
                        .toList(),
                  ),
      ],
    );
  }
}



class SuggestionSkeletonLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) => Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 16,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 14,
                                      height: 14,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      width: 100,
                                      height: 12,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                width: 60,
                                height: 16,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}