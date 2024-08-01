import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticketron/models/event_model.dart'; 

class EventService {
  static const String baseUrl = 'https://api-ticketron-jvmw.onrender.com/api';

  // Get all events
  Future<List<Event>> getAllEvents(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/events?userId=$userId'));
    // print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(response);
      return data.map((e) => Event.fromMap(e)).toList();
    } else {
      print('Failed to loading events');
      throw Exception('Failed to load events');
    }
  }

  // Get events for a given organizer
  Future<List<Event>> getEventsForOrganizer(String organizerId) async {
    final response = await http.get(Uri.parse('$baseUrl/events/organizer/$organizerId'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print(data);
      return data.map((e) => Event.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load events for organizer');
    }
  }

  // Get event by ID
  Future<Event> getEventById(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$eventId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Event.fromMap(data);
    } else {
      throw Exception('Failed to load event');
    }
  }


  // Get organizer statistics
  Future<Map<String, dynamic>> getOrganizerStatistics(String organizerId) async {
    try {

    // "success": true,
    // "data": {
    //     "totalRevenue": 7200,
    //     "totalSoldTickets": 47,
    //     "totalEvents": 7,
    //     "bestTicketType": "REGULAR",
    //     "bestTicketTypeQuantity": 45
    // }

      final response = await http.get(Uri.parse('$baseUrl/organizers/$organizerId/kpis'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("data: $data");
        return {
          'totalRevenue': data['data']['totalRevenue'],
          'totalSoldTickets': data['data']['totalSoldTickets'],
          'totalEvents': data['data']['totalEvents'],
          'bestTicketType': data['data']['bestTicketType'],
          'bestTicketQuantity': data['data']['bestTicketTypeQuantity'],
        };
      } else {
        print('Failed to load event statistics: ${response.body}');
        throw Exception('Failed to load event statistics');
      }
     
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  // Get event statistics
  Future<Map<String, dynamic>> getEventStatistics(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/events/$eventId/statistics'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("data: $data");
      return {
        'totalTickets': data['data']['totalTickets'],
        'totalRevenue': data['data']['totalRevenue'],
        'soldTickets': data['data']['soldTickets'],
        'canceledTickets': data['data']['canceledTickets'],
      };
    } else {
      print('Failed to load event statistics: ${response.body}');
      throw Exception('Failed to load event statistics');
    }
  }

  // Create a new event
  Future<Event> createEvent(Event event) async {
    final response = await http.post(
      Uri.parse('$baseUrl/events'),
      headers: {'Content-Type': 'application/json'},
      body: event.toJson(),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return Event.fromMap(data);
    } else {
      throw Exception('Failed to create event');
    }
  }

  // Update an event
  Future<Event> updateEvent(String eventId, Event event) async {
    final response = await http.put(
      Uri.parse('$baseUrl/events/$eventId'),
      headers: {'Content-Type': 'application/json'},
      body: event.toJson(),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Event.fromMap(data);
    } else {
      throw Exception('Failed to update event');
    }
  }

  // Delete an event
  Future<void> deleteEvent(String eventId) async {
    final response = await http.delete(Uri.parse('$baseUrl/events/$eventId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete event');
    }
  }



  // Fetch event suggestions based on user ID
  Future<List<Event>> getEventsSuggestions(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId/suggestions');
    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("suggested events: $data");
      return data.map((eventJson) => Event.fromMap(eventJson)).toList();
    } else {
      throw Exception('Failed to load event suggestions');
    }
  }

  
  // Get favorited events for a user
  Future<List<Event>> getFavoritedEvents(String userId) async {
    final url = Uri.parse('$baseUrl/users/$userId/favorites');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((eventJson) => Event.fromMap(eventJson)).toList();
    } else {
      throw Exception('Failed to load favorited events');
    }
  }

  // Toggle favorite/unfavorite event for a user
  Future<void> toggleFavoriteEvent(String userId, String eventId) async {
    final url = Uri.parse('$baseUrl/events/$eventId/toggleFavorite');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle favorite event');
    }
  }

}
