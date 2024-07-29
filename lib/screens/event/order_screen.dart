import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
// import 'package:ticketron/screens/event/order_complete.dart';
import 'package:ticketron/screens/payment/payment_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

class DetailOrderScreen extends StatelessWidget {
  final Event event;
  final int totalPrice;
  final String ticketType;
  final int quantity;
  final String phone;
  final String email;
  final String attendanceId;

  const DetailOrderScreen(
      {super.key,
      required this.event,
      required this.totalPrice,
      required this.ticketType,
      required this.quantity,
      required this.phone,
      required this.email, required this.attendanceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Order'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Logic for sharing the QR code
            },
            icon: SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Padding(
              padding: const EdgeInsets.all(Constants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EventDetailCard(event: event),
                  const SizedBox(height: Constants.paddingLarge),
                  OrderSummary(event: event, totalPrice: totalPrice, ticketType: ticketType, quantity: quantity),
                  const SizedBox(height: Constants.paddingLarge),
                  PaymentMethodSection(email: email, phone: phone,),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OrderTotalSection(event: event, totalPrice: totalPrice, ticketType: ticketType, quantity: quantity, attendanceId: attendanceId,),
          ),
        ],
      ),
    );
  }
}

class EventDetailCard extends StatelessWidget {
  final Event event;

  const EventDetailCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: event.images[0],
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: Constants.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: Constants.bodyText,
                ),
                const SizedBox(height: Constants.paddingSmall),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 16, color: Constants.greyColor),
                    const SizedBox(width: Constants.paddingSmall),
                    Text(
                      '${getFormattedDate(event.date)}',
                      style: Constants.secondaryBodyText,
                    ),
                  ],
                ),
                const SizedBox(height: Constants.paddingSmall),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 16, color: Constants.greyColor),
                    const SizedBox(width: Constants.paddingSmall),
                    Text(
                      '${event.time}',
                      style: Constants.secondaryBodyText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final Event event;
  final int totalPrice;
  final String ticketType;
  final int quantity;

  const OrderSummary(
      {super.key,
      required this.event,
      required this.totalPrice,
      required this.ticketType,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    double subtotal = totalPrice.toDouble();
    double fees = subtotal * 0.06; // 6% fees
    double total = subtotal + fees;

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order summary',
            style: Constants.heading3,
          ),
          const SizedBox(height: Constants.paddingMedium),
          _buildSummaryRow('${quantity}X $ticketType price',
              '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: Constants.paddingSmall),
          _buildSummaryRow('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: Constants.paddingSmall),
          _buildSummaryRow('Fees', '\$${fees.toStringAsFixed(2)}'),
          const Divider(height: Constants.paddingLarge),
          _buildSummaryRow('Total', '\$${total.toStringAsFixed(2)}',
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal ? Constants.heading3 : Constants.bodyText,
        ),
        Text(
          value,
          style: isTotal ? Constants.heading3 : Constants.bodyText,
        ),
      ],
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  final String paymentMethod = 'PayPal';
  final String email;
  final String phone;

  const PaymentMethodSection({super.key, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment method',
                style: Constants.heading3,
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to change payment method
                },
                child: const Text(
                  'Change',
                  style: TextStyle(color: Constants.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.paddingMedium),
          Row(
            children: [
              SvgPicture.asset(
                CustomIcons.paypal,
                width: 40,
                height: 40,
                color: Colors.blue,
              ),
              const SizedBox(width: Constants.paddingMedium),
               Text(
                '$paymentMethod\n$email',
                style: Constants.bodyText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderTotalSection extends StatelessWidget {
  final Event event;
  final int totalPrice;
  final String ticketType;
  final int quantity;
  final String attendanceId;  


  const OrderTotalSection({super.key, required this.event, required this.totalPrice, required this.ticketType, required this.quantity, required this.attendanceId});

  @override
  Widget build(BuildContext context) {
    double subtotal = totalPrice.toDouble();
    double fees = subtotal * 0.06; // Example fee calculation
    double total = subtotal + fees;

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: Constants.heading3.copyWith(color: Constants.primaryColor),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle order placement
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(attendanceId: attendanceId, quantity:quantity, totalPrice:total, ticketType:ticketType)));

              //move to order complete screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => OrderCompleteScreen(),
              //   ),
              // );
            },
            child: const Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
