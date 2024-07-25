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
