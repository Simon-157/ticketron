import 'package:flutter/material.dart';
import 'package:ticketron/utils/constants.dart';

class OrderCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
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
            Text(
              'Order Complete',
              style: Constants.heading1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.paddingSmall),
            Text(
              'Your payment was successful!\nSee you at the event',
              style: Constants.bodyText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Constants.paddingLarge),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ticket view page
              },
              child: const Text('View ticket'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: Constants.buttonText,
              ),
            ),
            const SizedBox(height: Constants.paddingMedium),
            OutlinedButton(
              onPressed: () {
                // Navigate to discover more events page
              },
              child: const Text('Discover more events'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: Constants.buttonText,
                side: BorderSide(color: Constants.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
