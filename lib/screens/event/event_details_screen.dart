import 'package:cached_network_image/cached_network_image.dart';
import 'package:ticketron/widgets/event_details/event_location_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/screens/event/get_ticket_screen.dart';
import 'package:ticketron/screens/event/live_event.dart';
import 'package:ticketron/screens/organizer_screens/edit_event_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';



class EventDetailsPage extends StatelessWidget {
  final Event event;
  final String role;

  EventDetailsPage({required this.event, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(Constants.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EventImageSection(event: event),
                const SizedBox(height: Constants.paddingMedium),
                EventInfoSection(event: event),
                const SizedBox(height: Constants.paddingMedium),
                EventDescriptionSection(description: event.description),
                const SizedBox(height: Constants.paddingMedium),
                OrganizerSection(organizer: event.organizer!),
                const SizedBox(height: Constants.paddingMedium),
                EventAgendaSection(agenda: event.agenda),
                const SizedBox(height: Constants.paddingMedium),
                EventLocationSection(location: event.location, latitude:5.7603 , longitude: 0.2199, ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TicketPurchaseSection(price: event.price, event: event, role: role),
          ),
        ],
      ),
    );
  }
}

class EventImageSection extends StatelessWidget {
  final Event event;

  EventImageSection({required this.event});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: CachedNetworkImage(
        imageUrl: event.images.isNotEmpty
            ? event.images[0]
            : "https://avatars.githubusercontent.com/u/79936608?v=4",
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }
}


class EventInfoSection extends StatelessWidget {
  final Event event;

  const EventInfoSection({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: Constants.heading2,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Row(
            children: [
              const SizedBox(width: Constants.paddingSmall),
              const Icon(Icons.calendar_today,
                  size: 16, color: Constants.greyColor),
              const SizedBox(width: Constants.paddingSmall),
              Text(
                '${event.date.day} ${getMonthName(event.date.month)} ${event.date.year}',
                style: Constants.bodyText,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time,
                  size: 16, color: Constants.greyColor),
              const SizedBox(width: Constants.paddingSmall),
              Text(
                event.time,
                style: Constants.bodyText,
              ),
            ],
          ),
        ])
      ],
    );
  }
}

class EventDescriptionSection extends StatelessWidget {
  final String description;

  EventDescriptionSection({required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About this event',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Text(
          description,
          style: Constants.bodyText,
        ),
      ],
    );
  }
}


class OrganizerSection extends StatelessWidget {
  final Organizer organizer;

  OrganizerSection({required this.organizer});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunch(smsUri.toString())) {
      await launch(smsUri.toString());
    } else {
      throw 'Could not send SMS to $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            organizer.logoUrl.isNotEmpty
                ? organizer.logoUrl
                : "https://avatars.githubusercontent.com/u/79936608?v=4",
          ),
        ),
        const SizedBox(width: Constants.paddingMedium),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  organizer.name,
                  style: Constants.heading3,
                ),
                if (organizer.isVerified)
                  const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 16.0,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Constants.paddingSmall),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.green),
                  onPressed: () => _makePhoneCall(organizer.phoneNumber),
                ),
                IconButton(
                  icon: const Icon(Icons.sms, color: Colors.blue),
                  onPressed: () => _sendSMS(organizer.phoneNumber),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class EventAgendaSection extends StatelessWidget {
  final List<AgendaItem> agenda;

  EventAgendaSection({required this.agenda});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Agenda',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Column(
          children: agenda.map((item) => AgendaCard(item: item)).toList(),
        ),
      ],
    );
  }
}

class AgendaCard extends StatelessWidget {
  final AgendaItem item;

  AgendaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: Constants.paddingSmall),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            item.speakerImageUrl.isNotEmpty
                ? item.speakerImageUrl
                : "https://avatars.githubusercontent.com/u/79936608?v=4",
          ),
        ),
        title: Text(item.title),
        subtitle: Text('${item.startTime} - ${item.endTime}\n${item.speaker}'),
      ),
    );
  }
}



class TicketPurchaseSection extends StatelessWidget {
  final Price price;
  final Event event;
  final String role;

  TicketPurchaseSection({required this.price, required this.event, required this.role});

  @override
  Widget build(BuildContext context) {
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
          role == 'organizer' ?  ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventEditScreen(event: event, ),
                ),
              );
            },
            child: const Text('Edit Event')
          ) : Text(
            price.premiumPrice > 0
                ? '\$${price.premiumPrice.toStringAsFixed(2)} - \$${price.regularPrice.toStringAsFixed(2)}'
                : 'FREE',
            style: Constants.heading3.copyWith(color: Constants.primaryColor),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LiveStreamScreen(event: event, isHost: false),
                ),
              );
            }, 
            child: const Text('Join Live'),
          
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  GetTicketScreen(event: event),
                ),
              );
            },
            child:  const Text('Get a Ticket'),
          ),
        ],
      ),
    );
  }
}