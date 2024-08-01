import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticketron/models/ticket_model.dart';


class TicketService {
  final String baseUrl = 'https://api-ticketron-jvmw.onrender.com/api';

  TicketService();

  Future<void> updateTicketStatus(String ticketId, String status) async {
    final url = '$baseUrl/tickets/$ticketId/status';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );

    _handleResponse(response);
  }

  Future<String> buyTicket(Ticket ticket) async {
    final url = '$baseUrl/tickets/buy';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ticket.toMap()),
    );

    final data = _handleResponse(response);
    return data['ticketId'];
  }

  Future<Ticket> getTicketDetails(String ticketId) async {
    final url = '$baseUrl/tickets/$ticketId';
    final response = await http.get(Uri.parse(url));

    final data = _handleResponse(response);
    return Ticket.fromMap(data);
  }

  Future<void> cancelTicket(String ticketId) async {
    final url = '$baseUrl/tickets/$ticketId';
    final response = await http.delete(Uri.parse(url));

    _handleResponse(response);
  }

  Future<List<Ticket>> listUserTickets(String userId) async {
    final url = '$baseUrl/users/$userId/tickets';
    final response = await http.get(Uri.parse(url));

    final data = _handleResponse(response);
    return (data as List).map((ticket) => Ticket.fromMap(ticket)).toList();
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
