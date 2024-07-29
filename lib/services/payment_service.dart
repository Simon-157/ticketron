
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class PaymentService {
  final String publicKey;
  final String encryptionKey;
  final String currency;
  final String redirectUrl;

  PaymentService({
    required this.publicKey,
    required this.encryptionKey,
    required this.currency,
    required this.redirectUrl,
  });

  Future<String> processPayment({
    required BuildContext context,
    required String amount,
    required String email,
    required String phoneNumber,
    required String fullName,
    required String txRef,
  }) async {
    final Customer customer = Customer(
      name: fullName,
      phoneNumber: phoneNumber,
      email: email,
    );

    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: publicKey,
      currency: currency,
      amount: amount,
      txRef: txRef,
      redirectUrl: redirectUrl,
      customer: customer,
      paymentOptions: "card, payattitude, barter, banktransfer, ussd",
      customization: Customization(
        title: "Your Payment Title",
        description: "Your Payment Description",
      ),
      isTestMode: true,
    );

    try {
      final ChargeResponse response = await flutterwave.charge();
      if (response.status == "successful") {
        print("Payment successful: ${response.toJson()}");
        return 'success';
      } else {
        print("Payment failed: ${response.status}");
        return 'failed';
      }
        } catch (error) {
      print("Payment error: $error");
      return 'failed';
    }
  }
}


class TicketPaymentService extends PaymentService {

  final String baseUrl = 'https://api-ticketron-jvmw.onrender.com';

  TicketPaymentService({required super.publicKey, required super.encryptionKey, required super.currency, required super.redirectUrl});

  Future<void> createPayment(Map<String, dynamic> paymentData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(paymentData),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      print(response.body);
      throw Exception('Failed to create payment record');
    }
  }

  Future<Map<String, dynamic>> getPayment(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/payments/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch payment record');
    }
  }

  Future<void> updatePayment(String id, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/payments/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update payment record');
    }
  }

  Future<void> deletePayment(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/payments/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete payment record');
    }
  }

  Future<List<Map<String, dynamic>>> getPaymentsForUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/payments/user/$userId'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch payment records for user');
    }
  }

  Future<double> getTotalRevenueForEvent(String eventId) async {
    final response = await http.get(Uri.parse('$baseUrl/revenue/event/$eventId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['totalRevenue'] as double;
    } else {
      throw Exception('Failed to fetch total revenue for event');
    }
  }
}
