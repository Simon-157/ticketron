import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/get_ticket_screen.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';

import '../../models/organizer_model.dart';

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

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
                EventLocationSection(location: event.location),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TicketPurchaseSection(price: event.price, event: event,),
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

  EventInfoSection({required this.event});

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
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Constants.greyColor),
            const SizedBox(width: Constants.paddingSmall),
            Text(
              '${event.date.day} ${getMonthName(event.date.month)} ${event.date.year}',
              style: Constants.bodyText,
            ),
          ],
        ),
        const SizedBox(height: Constants.paddingSmall),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: Constants.greyColor),
            const SizedBox(width: Constants.paddingSmall),
            Text(
              event.time,
              style: Constants.bodyText,
            ),
          ],
        ),
        const SizedBox(height: Constants.paddingSmall),
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: Constants.greyColor),
            const SizedBox(width: Constants.paddingSmall),
            Text(
              event.location,
              style: Constants.bodyText,
            ),
          ],
        ),
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
            Text(
              organizer.name,
              style: Constants.heading3,
            ),
            const SizedBox(height: Constants.paddingSmall),
            if (organizer.isVerified)
              const Text(
                'Verified',
                style: TextStyle(
                  color: Colors.blue,
                ),
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

class EventLocationSection extends StatelessWidget {
  final String location;

  EventLocationSection({required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: Constants.heading3,
        ),
        const SizedBox(height: Constants.paddingSmall),
        Text(
          location,
          style: Constants.bodyText,
        ),
        const SizedBox(height: Constants.paddingSmall),
        // Add a placeholder for map or any other widget you want
        Container(
          height: 200,
          color: Colors.grey[200],
          child: const Center(child: Text('Map Placeholder')),
        ),
      ],
    );
  }
}



class TicketPurchaseSection extends StatelessWidget {
  final Price price;
  final Event event;

  TicketPurchaseSection({required this.price, required this.event});

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
          Text(
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
                  builder: (context) => GetTicketScreen(event: event),
                ),
              );
            },
            child: const Text('Get a Ticket'),
          ),
        ],
      ),
    );
  }
}