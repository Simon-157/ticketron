import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/organizer_data.dart';

class QRCodeScreen extends StatelessWidget {
  final Ticket ticket;

  QRCodeScreen({required this.ticket});

  Event getEventForTicket(String eventId) {
    return dummyEvents.firstWhere((event) => event.eventId == eventId);
  }

  @override
  Widget build(BuildContext context) {
    Event event = getEventForTicket(ticket.eventId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code', style: TextStyle(color: Color.fromARGB(193, 0, 0, 0), fontWeight: FontWeight.bold, fontSize: 20), ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Logic for sharing the QR code
            },
            icon:  SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),],

      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: event.images[0],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${event.date.month}/${event.date.day}/${event.date.year}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          event.time,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: CachedNetworkImage(
                                  imageUrl: 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${ticket.qrcode}',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb, color: Colors.yellow[700]),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Please show this code at the event and scan it to proceed.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic for downloading the image
                  },
                  icon: const Icon(Icons.download, color: Colors.white,),
                  label: const Text('Download Code', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Logic for sharing the QR code
                  },
                  icon: const Icon(Icons.share, ),
                  label: const Text('Share Code', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Constants.primaryColor),),
                  style: ElevatedButton.styleFrom(

                    // backgroundColor: Colors.,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
