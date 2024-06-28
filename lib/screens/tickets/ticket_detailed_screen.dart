import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/dummydata.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  const TicketDetailScreen({super.key, required this.ticket});

  Event getEventForTicket(int eventId) {
    return events.firstWhere((event) => event.id == eventId);
  }

  @override
  Widget build(BuildContext context) {
    Event event = getEventForTicket(ticket.eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      imageUrl:event.images[0].url,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${event.date.month}/${event.date.day}/${event.date.year}'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(event.time),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Venue',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(event.location),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Seat',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(ticket.seat),
                    ],
                  ),
                  const Divider(
                    height: 32,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: 'https://barcode.tec-it.com/barcode.ashx?data=${ticket.barcode}',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for downloading the image
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download Image'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logic for showing the QR code
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text('Show QR Code'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
