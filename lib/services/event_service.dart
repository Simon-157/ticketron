import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketron/models/event_model.dart'; 

class EventService {
  final CollectionReference _eventsCollection =
      FirebaseFirestore.instance.collection('events');

  Future<void> createEvent(Event event) async {
    try {
      DocumentReference eventDoc = await _eventsCollection.add(event.toMap());
      String eventId = eventDoc.id;
      await eventDoc.update({'eventId': eventId});
    } catch (e) {
      print("Error creating event: $e");
      rethrow; 
    }
  }

  Future<Event?> getEventById(String eventId) async {
    try {
      DocumentSnapshot eventDoc = await _eventsCollection.doc(eventId).get();
      if (eventDoc.exists) {
        return Event.fromMap(eventDoc.data() as Map<String, dynamic>);
      }
      return null; 
    } catch (e) {
      print("Error getting event by ID: $e");
      rethrow; 
    }
  }

  Future<List<Event>> getEventsByOrganizer(String organizerId) async {
    try {
      QuerySnapshot eventsQuery = await _eventsCollection
          .where('organizer.organizerId', isEqualTo: organizerId)
          .get();
      List<Event> events = eventsQuery.docs.map((doc) => Event.fromMap(doc.data() as Map<String, dynamic>)).toList();
      return events;
    } catch (e) {
      print("Error getting events by organizer: $e");
      rethrow; 
    }
  }

  Future<void> updateEvent(Event event) async {
    try {
      await _eventsCollection.doc(event.eventId).update(event.toMap());
    } catch (e) {
      print("Error updating event: $e");
      rethrow; 
    }
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventsCollection.doc(eventId).delete();
    } catch (e) {
      print("Error deleting event: $e");
      rethrow; 
    }
  }
}

