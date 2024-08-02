import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticketron/models/attendance_model.dart';

class EventAttendanceService {
  final String baseUrl = 'https://api-ticketron-jvmw.onrender.com/api';

  EventAttendanceService();

  Future<String> createAttendance(EventAttendance attendance) async {
    final response = await http.post(
      Uri.parse('$baseUrl/attendance'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(attendance.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['attendanceId'];
    } else {
      print(response.body);
      throw Exception('Failed to create attendance record');
    }

  }

  Future<EventAttendance> getAttendance(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/attendance/$id'));

    if (response.statusCode == 200) {
      return EventAttendance.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch attendance record');
    }
  }

  Future<void> updateAttendance(String id, AttendanceStatus attendanceStatus, PaymentStatus paymentStatus) async {
    final response = await http.put(
      Uri.parse('$baseUrl/attendance/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'attendanceStatus': attendanceStatus.index,
        'paymentStatus': paymentStatus.index,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update attendance record');
    }
  }

  // update attendance by userid and eventid
  Future<void> updateAttendanceByUserIdAndEventId( String userId, String eventId)async {
      final response = await http.put(
      Uri.parse('$baseUrl/attendance/$userId/$eventId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'attendanceStatus': 1,
        'paymentStatus': 1,
        'userId': userId,
        'eventId':eventId
      }),

    );

    print(response);

    if (response.statusCode != 200) {
      print(response);
      throw Exception('Failed to update attendance record');
    }
  }

  Future<void> deleteAttendance(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/attendance/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete attendance record');
    }
  }

  Future<List<Map<String, dynamic>>> getAttendanceListForEvent(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/attendance/event/$eventId'));
    print(response.body);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return []; // Return an empty list as a positive indication
    } else {
      print(response.body);
      throw Exception('Failed to fetch attendance list for event');
    }
  }
}
