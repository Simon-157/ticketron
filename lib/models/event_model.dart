// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

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
   bool? isLiked;


  

  Event({
    required this.eventId,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.description,
    required this.organizer,
    required this.agenda,
    required this.images,
    this.videoUrl,
    required this.ticketsLeft,
    required this.category,
    this.locationMapUrl,
    required this.totalCapacityNeeded,
    this.isLiked,
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
      eventId: map['eventId'] as String,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(int.tryParse(map['date'].toString()) ?? 0),
      time: map['time'] as String,
      location: map['location'] as String,
      price: Price.fromMap(map['price'] as Map<String,dynamic>),
      description: map['description'] as String,
      organizer: Organizer.fromMap(map['organizer'] as Map<String,dynamic>),
      agenda: List<AgendaItem>.from((map['agenda'] as List<dynamic>).map<AgendaItem>((x) => AgendaItem.fromMap(x as Map<String,dynamic>),),),
      images: List<dynamic>.from((map['images'] as List<dynamic>),
      ),
      videoUrl: map['videoUrl'] != null ? map['videoUrl'] as String : null,
      ticketsLeft: map['ticketsLeft'] as int,
      category: map['category'] as String,
      locationMapUrl: map['locationMapUrl'] != null ? map['locationMapUrl'] as String : null,
      totalCapacityNeeded: int.tryParse(map['totalCapacityNeeded'].toString()) ?? 0,
      isLiked: map['isLiked'] != null ? map['isLiked'] as bool : false,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Event(eventId: $eventId, title: $title, date: $date, time: $time, location: $location, price: $price, description: $description, organizer: $organizer, agenda: $agenda, images: $images, videoUrl: $videoUrl, ticketsLeft: $ticketsLeft, category: $category, locationMapUrl: $locationMapUrl, totalCapacityNeeded: $totalCapacityNeeded)';
  }

  @override
  bool operator ==(covariant Event other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventId == eventId &&
      other.title == title &&
      other.date == date &&
      other.time == time &&
      other.location == location &&
      other.price == price &&
      other.description == description &&
      other.organizer == organizer &&
      listEquals(other.agenda, agenda) &&
      listEquals(other.images, images) &&
      other.videoUrl == videoUrl &&
      other.ticketsLeft == ticketsLeft &&
      other.category == category &&
      other.locationMapUrl == locationMapUrl &&
      other.totalCapacityNeeded == totalCapacityNeeded;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
      title.hashCode ^
      date.hashCode ^
      time.hashCode ^
      location.hashCode ^
      price.hashCode ^
      description.hashCode ^
      organizer.hashCode ^
      agenda.hashCode ^
      images.hashCode ^
      videoUrl.hashCode ^
      ticketsLeft.hashCode ^
      category.hashCode ^
      locationMapUrl.hashCode ^
      totalCapacityNeeded.hashCode;
  }


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
