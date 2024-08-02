// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  final String ticketId;
  final String eventId;
  final String userId;
  final String seat;
  final String ticketType;
  final int quantity;
  final double totalPrice;
  final String status;
  final String barcode;
  final String qrcode;

  Ticket({
    required this.ticketId,
    required this.eventId,
    required this.userId,
    required this.seat,
    required this.ticketType,
    required this.quantity,
    required this.totalPrice,
    required this.status,
    required this.barcode,
    required this.qrcode,
  });

  Ticket copyWith({
    String? ticketId,
    String? eventId,
    String? userId,
    String? seat,
    String? ticketType,
    int? quantity,
    double? totalPrice,
    String? status,
    String? barcode,
    String? qrcode,
  }) {
    return Ticket(
      ticketId: ticketId ?? this.ticketId,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      seat: seat ?? this.seat,
      ticketType: ticketType ?? this.ticketType,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      barcode: barcode ?? this.barcode,
      qrcode: qrcode ?? this.qrcode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticketId': ticketId,
      'eventId': eventId,
      'userId': userId,
      'seat': seat,
      'ticketType': ticketType,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'status': status,
      'barcode': barcode,
      'qrcode': qrcode,
    };
  }
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      ticketId: map['ticketId'] ?? '',
      eventId: map['eventId'] ?? ' ',
      userId: map['userId'] ?? ' ',
      seat: map['seat'] ?? ' ',
      ticketType: map['ticketType'] ?? ' ',
      quantity: map['quantity'] ?? 1,
      totalPrice: map['totalPrice'] is int ? (map['totalPrice'] as int).toDouble() : map['totalPrice'] ?? 0.0,
      status: map['status'] ?? ' ',
      barcode: map['barcode'] ?? ' ',
      qrcode: map['qrcode'] ?? ' ',
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Ticket(ticketId: $ticketId, eventId: $eventId, userId: $userId, seat: $seat, ticketType: $ticketType, quantity: $quantity, totalPrice: $totalPrice, status: $status, barcode: $barcode, qrcode: $qrcode)';
  }

  factory Ticket.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('Document data is null');
    }
    return Ticket.fromMap(data);
  }
}
