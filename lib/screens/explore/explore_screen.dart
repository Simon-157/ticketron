import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/dummydata.dart';
import 'package:ticketron/widgets/home/suggestions_foryou_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Event> filteredEvents = [];
  String selectedLocation = 'California';
  String searchQuery = '';
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    filteredEvents = events;
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _filterByCategory();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(
              selectedLocation: selectedLocation,
              onSearchChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _applyFilters();
                });
              },
              onLocationChanged: (value) {
                setState(() {
                  selectedLocation = value;
                  _applyFilters();
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
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

  void _applyFilters() {
    setState(() {
      List<Event> eventsBySearch = events
          .where((event) =>
              event.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();

      List<Event> eventsByLocation = events
          .where((event) => event.location
              .toLowerCase()
              .contains(selectedLocation.toLowerCase()))
          .toList();

      List<Event> eventsByCategory = events
          .where((event) =>
              selectedCategory.isEmpty ||
              event.category
                  .toLowerCase()
                  .contains(selectedCategory.toLowerCase()))
          .toList();

      // Combine the filtered lists, considering that each filter is applied independently
      Set<Event> combinedSet = Set.from(eventsBySearch)
        ..addAll(eventsByLocation)
        ..addAll(eventsByCategory);

      filteredEvents = combinedSet.toList();

      // Debug print to check the filtered list
      print('Filtered Events: ${filteredEvents.map((e) => e.title).toList()}');
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
                  _applyFilters();
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
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
                // VerticalDivider(color: Colors.grey),
                Icon(Icons.location_on,
                    color: Color.fromARGB(255, 250, 251, 252)),
                SizedBox(width: 8),
                DropdownButton<String>(
                  dropdownColor:  Color.fromARGB(255, 162, 163, 163),
                  value: selectedLocation,
                  underline: Container(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onLocationChanged(newValue);
                    }
                  },
                  items: <String>['California', 'New York', 'Brooklyn']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(

                      value: value,
                      child: Text(
                        value,
                        style:
                            TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
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
