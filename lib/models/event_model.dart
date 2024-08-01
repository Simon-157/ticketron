import 'dart:convert';
import 'package:ticketron/models/organizer_model.dart';

class Event {
  String eventId;
  String title;
  DateTime date;
  String time;
  String location;
  Price price;
  String description;
  Organizer? organizer;
  List<AgendaItem> agenda;
  List<dynamic> images;
  String? videoUrl;
  int ticketsLeft;
  String category;
  String? locationMapUrl;
  int totalCapacityNeeded;
  bool isLiked;

  Event({
    required this.eventId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.description,
    this.organizer,
    required this.agenda,
    required this.images,
    this.videoUrl,
    required this.ticketsLeft,
    required this.category,
    this.locationMapUrl,
    required this.totalCapacityNeeded,
    this.isLiked = false, // Default to false
  });

  bool get isFree {
    return price.regularPrice == 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventId': eventId,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'location': location,
      'price': price.toMap(),
      'description': description,
      'organizer': organizer?.toMap(),
      'agenda': agenda.map((x) => x.toMap()).toList(),
      'images': images,
      'videoUrl': videoUrl,
      'ticketsLeft': ticketsLeft,
      'category': category,
      'locationMapUrl': locationMapUrl,
      'totalCapacityNeeded': totalCapacityNeeded,
      'isLiked': isLiked,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map['eventId'] as String? ?? '', // Default empty string if null
      title: map['title'] as String? ?? '', // Default empty string if null
      date: DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(map['date']?.toString() ?? '0') ?? 0,
      ),
      time: map['time'] as String? ?? '', // Default empty string if null
      location: map['location'] as String? ?? '', // Default empty string if null
      price: Price.fromMap(map['price'] as Map<String, dynamic>? ?? {}), // Handle null maps
      description: map['description'] as String? ?? '', // Default empty string if null
      organizer: map['organizer'] != null
          ? Organizer.fromMap(map['organizer'] as Map<String, dynamic>)
          : null,
      agenda: List<AgendaItem>.from(
        (map['agenda'] as List<dynamic>? ?? []).map(
          (x) => AgendaItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      images: List<dynamic>.from(map['images'] as List<dynamic>? ?? []),
      videoUrl: map['videoUrl'] as String? ?? '',
      ticketsLeft: map['ticketsLeft'] as int? ?? 0, // Default to 0 if null
      category: map['category'] as String? ?? '', // Default empty string if null
      locationMapUrl: map['locationMapUrl'] as String? ?? '',
      totalCapacityNeeded: int.tryParse(map['totalCapacityNeeded']?.toString() ?? '0') ?? 0,
      isLiked: map['isLiked'] as bool? ?? false, // Default to false if null
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);
}


class Price {
   double premiumPrice;
   double regularPrice;

  Price({
    required this.premiumPrice,
    required this.regularPrice,
  });

 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'premiumPrice': premiumPrice,
      'regularPrice': regularPrice,
    };
  }

  factory Price.fromMap(Map<String, dynamic> map) {
    return Price(
      premiumPrice: map['premiumPrice'] as double,
      regularPrice: map['regularPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Price.fromJson(String source) => Price.fromMap(json.decode(source) as Map<String, dynamic>);

}

class AgendaItem {
  final String title;
  final String speaker;
  final String startTime;
  final String endTime;
  final String speakerImageUrl;

  AgendaItem({
    required this.title,
    required this.speaker,
    required this.startTime,
    required this.endTime,
    required this.speakerImageUrl,
  });

  AgendaItem copyWith({
    String? title,
    String? speaker,
    String? startTime,
    String? endTime,
    String? speakerImageUrl,
  }) {
    return AgendaItem(
      title: title ?? this.title,
      speaker: speaker ?? this.speaker,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      speakerImageUrl: speakerImageUrl ?? this.speakerImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'speaker': speaker,
      'startTime': startTime,
      'endTime': endTime,
      'speakerImageUrl': speakerImageUrl,
    };
  }

  factory AgendaItem.fromMap(Map<String, dynamic> map) {
    return AgendaItem(
      title: map['title'] as String,
      speaker: map['speaker'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      speakerImageUrl: map['speakerImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AgendaItem.fromJson(String source) => AgendaItem.fromMap(json.decode(source) as Map<String, dynamic>);

}