import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/dummydata.dart';

class TicketDetailScreen extends StatelessWidget {
  final Ticket ticket;

  TicketDetailScreen({required this.ticket});

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
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: event.images[0].url,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                         decoration: BoxDecoration(
                        color: const Color.fromARGB(127, 238, 238, 238),
                          borderRadius: BorderRadius.circular(16.0), 
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${event.date.month}/${event.date.day}/${event.date.year}',
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(event.time),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Venue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(event.location),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Seat',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(ticket.seat),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 32,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                     
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://barcode.tec-it.com/barcode.ashx?data=${ticket.barcode}',
                                        height: 80,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
             Padding(
              padding: const EdgeInsets.all( 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                    ),
                    onPressed: () {
                      // Logic for downloading the image
                    },
                    icon: const Icon(Icons.download, color: Colors.white,),
                    label: const Text('Download Image', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  ElevatedButton.icon(
                   
                    onPressed: () {
                      // Logic for showing the QR code
                    },
                    icon: const Icon(Icons.qr_code,),
                    label: const Text('Show QR Code', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
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
