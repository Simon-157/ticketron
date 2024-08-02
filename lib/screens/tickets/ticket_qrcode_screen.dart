import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class QRCodeScreen extends StatefulWidget {
  final Ticket ticket;

  QRCodeScreen({required this.ticket});

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  EventService _eventService = EventService();

  Future<Event> getEventForTicket(String eventId) async {
    return _eventService.getEventById(eventId);
  }

  Future<void> downloadQRCode(String imageUrl) async {
    try {
      // Request permissions
      if (await Permission.storage.request().isGranted) {
        var response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          Uint8List bytes = response.bodyBytes;
          final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(bytes),
            quality: 60,
            name: "qr_code_${DateTime.now().millisecondsSinceEpoch}",
          );
          if (result['isSuccess']) {
            print('Image saved to gallery');
          } else {
            print(result);
            print('Error saving image to gallery');
          }
        } else {
          print('Failed to download image');
        }
      } else {
        print('Storage permission denied');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

  Future<void> shareQRCode(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/qr_code.png').create();
        file.writeAsBytesSync(bytes);
        Event event = await getEventForTicket(widget.ticket.eventId);  // Await the event title
        Share.shareXFiles([XFile(file.path)],
            text: 'QR Code for your ticket to ${event.title}');
      }
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrCodeUrl = 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${widget.ticket.qrcode}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Code',
          style: TextStyle(
              color: Color.fromARGB(193, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              shareQRCode(qrCodeUrl);
            },
            icon: SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Event>(
        future: getEventForTicket(widget.ticket.eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading event data'));
          } else {
            Event event = snapshot.data!;
            return Column(
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: CachedNetworkImage(
                                          imageUrl: event.images[0],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        event.title,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
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
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(16.0),
                                      child: CachedNetworkImage(
                                        imageUrl: qrCodeUrl,
                                        height: 150,
                                        width: 200,
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
                          downloadQRCode(qrCodeUrl);
                        },
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Download Code',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          shareQRCode(qrCodeUrl);
                        },
                        icon: const Icon(
                          Icons.share,
                        ),
                        label: const Text(
                          'Share Code',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Constants.primaryColor),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
