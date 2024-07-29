import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ticketron/models/attendance_model.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/payment_service.dart';
import 'package:ticketron/services/attendance_service.dart';
import 'package:ticketron/services/ticket_service.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  final String attendanceId;
  final int quantity;
  final double totalPrice;
  final String ticketType;

  const PaymentScreen(
      {super.key,
      required this.attendanceId,
      required this.quantity,
      required this.totalPrice,
      required this.ticketType});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late TicketPaymentService paymentService;
  late TicketService ticketService;
  late EventAttendanceService attendanceService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    paymentService = TicketPaymentService(
        publicKey: "FLWPUBK_TEST-3c2d76572fb0809eda7c476ff0808126-X",
        encryptionKey: "FLWSECK_TESTa242846c21f9",
        currency: "GHS",
        redirectUrl: "/payment/success");
    attendanceService = EventAttendanceService();
    ticketService = TicketService();
    authService = AuthService();
  }

  String generateTxRef() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  String generateCode() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    Random random = Random();

    String code = '';
    for (int i = 0; i < 4; i++) {
      code += letters[random.nextInt(letters.length)];
    }
    for (int i = 0; i < 4; i++) {
      code += numbers[random.nextInt(numbers.length)];
    }
    return code;
  }

  String generateSeatNumber() {
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';
    Random random = Random();

    return '${letters[random.nextInt(letters.length)]}${numbers[random.nextInt(numbers.length)]}${numbers[random.nextInt(numbers.length)]}${numbers[random.nextInt(numbers.length)]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutterwave Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final code = generateCode();
            final uniqueTxRef = generateTxRef();
            final qrCode = code;
            final barCode = code;
            final seatNumber = generateSeatNumber();
            final res = await paymentService.processPayment(
              context: context,
              amount: "1000",
              email: "user@example.com",
              phoneNumber: "08012345678",
              fullName: "John Doe",
              txRef: uniqueTxRef,
            );

            if (res == "success") {
              print('attendanceId: ${widget.attendanceId}');
              print('uniqueTxRef: $uniqueTxRef');

              try {
                // Create payment record
                await paymentService.createPayment({
                  'txRef': uniqueTxRef,
                  'paymentType': "card",
                  'paymentId': uniqueTxRef,
                  'attendanceId': widget.attendanceId,
                  'amount': 1000,
                  'email': "user@example.com",
                  'status': 'paid',
                  'userId': authService.getCurrentUser()!.uid,
                  'eventId': widget.attendanceId,
                });

                // Update attendance record
                await attendanceService.updateAttendance(widget.attendanceId,
                    AttendanceStatus.notAttended, PaymentStatus.paid);

                // CREATE TICKET RECORD
                await ticketService.buyTicket(Ticket(
                  eventId: widget.attendanceId,
                  userId: authService.getCurrentUser()!.uid,
                  status: "active",
                  ticketId: uniqueTxRef,
                  seat: seatNumber,
                  quantity: widget.quantity,
                  ticketType: widget.ticketType,
                  totalPrice: widget.totalPrice,
                  barcode: barCode,
                  qrcode: qrCode,
                ));

                Navigator.of(context).pushNamed("/payment/success");
              } catch (error) {
                print("Payment error: $error");
                showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(
                      title: Text("Something went wrong, please try again")),
                );
              }
            } else if (res == "failed") {
              showDialog(
                context: context,
                builder: (_) =>
                    const AlertDialog(title: Text("Payment Failed")),
              );
            }
          },
          child: const Text("Pay Now"),
        ),
      ),
    );
  }
}
