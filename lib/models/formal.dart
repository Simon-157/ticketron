// class Ticket {
//   final String ticketId;
//   final int eventId;
//   final String userId;
//   final String seat;
//   final String ticketType;
//   final int quantity;
//   final double totalPrice;
//   final String status;
//   final String barcode;
//   final String qrcode;

//   Ticket({
//     required this.ticketId,
//     required this.eventId,
//     required this.userId,
//     required this.seat,
//     required this.ticketType,
//     required this.quantity,
//     required this.totalPrice,
//     required this.status,
//     required this.barcode,
//     required this.qrcode,
//   });
// }

// class Attendance {
//   final String userId;
//   final int eventId;
//   final DateTime attendedAt;

//   Attendance({
//     required this.userId,
//     required this.eventId,
//     required this.attendedAt,
//   });
// }

// class Message {
//   final String messageId;
//   final String senderId;
//   final String receiverId;
//   final String eventId;
//   final String content;
//   final DateTime timestamp;

//   Message({
//     required this.messageId,
//     required this.senderId,
//     required this.receiverId,
//     required this.eventId,
//     required this.content,
//     required this.timestamp,
//   });
// }

// class Organizer {
//   final String organizerId;
//   final String name;
//   final bool isVerified;
//   final String logoUrl;
//   final String category;
//   final String about;

//   Organizer({
//     required this.organizerId,
//     required this.name,
//     required this.isVerified,
//     required this.logoUrl,
//     required this.category,
//     required this.about
//   });
// }

// class User {
//   final String userId;
//   final String name;
//   final String email;
//   final String avatarUrl;

//   User({
//     required this.userId,
//     required this.name,
//     required this.email,
//     required this.avatarUrl,
//   });
// }

// class Event {
//   final String eventId;
//   final String title;
//   final DateTime date;
//   final String time;
//   final String location;
//   final Price price;
//   final String description;
//   final Organizer organizer;
//   final List<AgendaItem> agenda;
//   final List<String> images;
//   final String? videoUrl;
//   final int ticketsLeft;
//   final String category;
//   final String? locationMapUrl;
//   final int totalCapacityNeeded;

//   Event({
//     required this.eventId,
//     required this.title,
//     required this.date,
//     required this.time,
//     required this.location,
//     required this.price,
//     required this.description,
//     required this.organizer,
//     required this.agenda,
//     required this.images,
//     required this.ticketsLeft,
//     required this.category,
//     required this.totalCapacityNeeded,
//     this.videoUrl,
//     this.locationMapUrl,
//   });



//  bool get isFree {
//     return price.regularPrice == 0;
//   }
// }

// class Price {
//   final double premiumPrice;
//   final double regularPrice;

//   Price({
//     required this.premiumPrice,
//     required this.regularPrice,
//   });
// }

// class AgendaItem {
//   final String title;
//   final String speaker;
//   final String startTime;
//   final String endTime;
//   final String speakerImageUrl;

//   AgendaItem({
//     required this.title,
//     required this.speaker,
//     required this.startTime,
//     required this.endTime,
//     required this.speakerImageUrl,
//   });
// }
