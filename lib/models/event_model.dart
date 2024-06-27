class Event {
  final int id;
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final Price price;
  final String description;
  final Organizer organizer;
  final List<AgendaItem> agenda;
  final List<Image> images;
  final String? videoUrl;
  final int ticketsLeft;
  final String category;
  final String? locationMapUrl;

  Event({
    required this.id,
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
  });



  

 bool get isFree {
    return price.regularPrice == 0;
  }
}

class Price {
  final double premiumPrice;
  final double regularPrice;

  Price({
    required this.premiumPrice,
    required this.regularPrice,
  });
}

class Organizer {
  final String name;
  final bool verified;

  String logoUrl;

  String category;

  Organizer({
    required this.name,
    required this.verified,
    required this.logoUrl,
    required this.category,
  });
}

class AgendaItem {
  final String title;
  final String speaker;
  final String startTime;
  final String endTime;

  String speakerImageUrl;

  AgendaItem({
    required this.title,
    required this.speaker,
    required this.startTime,
    required this.endTime,
    required this.speakerImageUrl,
  });
}

class Image {
  final String url;

  Image({
    required this.url,
  });
}


