import 'package:flutter/material.dart';
import 'package:ticketron/services/payment_service.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentService paymentService;

  @override
  void initState() {
    super.initState();
    paymentService = PaymentService(
      publicKey: "FLWPUBK_TEST-3c2d76572fb0809eda7c476ff0808126-X",
      encryptionKey: "FLWSECK_TESTa242846c21f9",
      currency: "GHS",
      redirectUrl: "/payment/success"
    );
  }

  String generateTxRef() {
    var uuid = Uuid();
    return uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutterwave Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final uniqueTxRef = generateTxRef();
            final res = await paymentService.processPayment(
              context: context,
              amount: "1000",
              email: "user@example.com",
              phoneNumber: "08012345678",
              fullName: "John Doe",
              txRef: uniqueTxRef,
            );

            if (res == "success") {
              Navigator.of(context).pushNamed("/payment/success");
            } else if (res == "failed") {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(title: Text("Payment Failed")),
              );
            }
          },
          child: const Text("Pay Now"),
        ),
      ),
    );
  }
}
