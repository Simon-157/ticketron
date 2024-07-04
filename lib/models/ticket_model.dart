import 'package:ticketron/models/user_model.dart';

class Ticket {
  final String id;
  final int eventId; // Reference to the Event ID
  final User user;
  final String seat;
  final String ticketType; // "Premium" or "Regular"
  final int quantity;
  final double totalPrice;
  final String status;  // "Upcoming" or "Past"
  final String barcode; 
  final String qrcode;  

  Ticket({
    required this.id,
    required this.eventId,
    required this.user,
    required this.seat,
    required this.ticketType,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.barcode,
    required this.qrcode,
  });
}
