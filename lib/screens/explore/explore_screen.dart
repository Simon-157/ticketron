import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/global/skeleton_loader_widget.dart';
import 'package:ticketron/widgets/home/suggestion_event_card.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late EventService eventService;
  AuthService authService = AuthService();  
  List<Event> filteredEvents = [];
  List<Event> allEvents = [];
  String selectedLocation = 'All';
  String searchQuery = '';
  String selectedCategory = '';
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    eventService = EventService();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    try {
      List<Event> events = await eventService.getAllEvents(authService.getCurrentUser()!.uid);
      setState(() {
        allEvents = events;
        filteredEvents = allEvents;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        errorMessage = 'Failed to load events';
        isLoading = false;
      });
    }
  }

  void _applyFilters(String key) {
    setState(() {
      switch (key) {
        case 'location':
          if (selectedLocation == 'All') {
            filteredEvents = allEvents;
          }
          filteredEvents = allEvents
              .where((event) => event.location.toLowerCase().contains(selectedLocation.toLowerCase()))
              .toList();
          break;
        case 'category':
          if (selectedCategory == 'All') {
            filteredEvents = allEvents;
            break;
          }
          filteredEvents = allEvents
              .where((event) => event.category.toLowerCase().contains(selectedCategory.toLowerCase()))
              .toList();
          break;
        case 'search':
          if (searchQuery.isEmpty) {
            filteredEvents = allEvents;
          }
          filteredEvents = allEvents
              .where((event) => event.title.toLowerCase().contains(searchQuery.toLowerCase()))
              .toList();
          break;
        default:
          filteredEvents = allEvents;
          break;
      }
    });
  }


  void _filterByCategory() {
    List<String> categories = ['All', 'Conference', 'Workshop', 'Meetup'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: categories.map((String category) {
            return ListTile(
              title: Text(category),
              onTap: () {
                setState(() {
                  selectedCategory = category == 'All' ? '' : category;
                  _applyFilters('category');
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _filterByCategory,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? SkeletonLoader()
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchBar(
                        selectedLocation: selectedLocation,
                        onSearchChanged: (value) {
                          searchQuery = value;
                          _applyFilters('search');
                        },
                        onLocationChanged: (value) {
                          selectedLocation = value;
                          _applyFilters('location');
                        },
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: filteredEvents.isEmpty
                            ? const Center(child: Text('No events match your search query.'))
                            : ListView.builder(
                                itemCount: filteredEvents.length,
                                itemBuilder: (context, index) {
                                  Event event = filteredEvents[index];
                                  return SuggestionCard(event: event);
                                },
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final String selectedLocation;
  final Function(String) onSearchChanged;
  final Function(String) onLocationChanged;

  SearchBar({
    required this.selectedLocation,
    required this.onSearchChanged,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search all events',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              onChanged: onSearchChanged,
            ),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: Constants.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  dropdownColor: const Color.fromARGB(255, 162, 163, 163),
                  value: selectedLocation,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onLocationChanged(newValue);
                    }
                  },
                  items: <String>['All','California', 'New York', 'Brooklyn']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
