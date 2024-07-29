import 'package:flutter/material.dart';
import 'package:ticketron/screens/tickets/ticket_detailed_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/organizer_data.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/order.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: Constants.paddingLarge),
            const Text(
              'Order Complete',
              style: Constants.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.paddingSmall),
            const Text(
              'Your payment was successful!\nSee you at the event',
              style: Constants.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.paddingLarge),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ticket view page
                Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDetailScreen(ticket: tickets[0],)));
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: Constants.buttonText,
              ),
              child: const Text('View ticket'),
            ),
            const SizedBox(height: Constants.paddingMedium),
            OutlinedButton(
              onPressed: () {
                // Navigate to explore events page
                Navigator.pushNamed(context, '/explore');
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: Constants.buttonText,
                side: const BorderSide(color: Constants.primaryColor),
              ),
              child: const Text('Discover more events'),
            ),
          ],
        ),
      ),
    );
  }
}
