import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/utils/constants.dart';

class AgendaItemWidget extends StatelessWidget {
  final AgendaItem item;

  AgendaItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(item.speakerImageUrl),
            radius: 20,
          ),
          SizedBox(width: Constants.paddingMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: Constants.bodyText,
              ),
              Text(
                '${item.startTime} - ${item.endTime}',
                style: Constants.secondaryBodyText,
              ),
              Text(
                item.speaker,
                style: Constants.secondaryBodyText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
