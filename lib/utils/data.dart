// import 'package:ticketron/models/event_model.dart';


// const String defaultImageUrl = "https://avatars.githubusercontent.com/u/79936608?v=4";
// const String defaultVideoUrl = "https://www.youtube.com/watch?v=3OUYkCkrApE";

// List<Event> upcomingEvents = [
//   Event(
//     id: 1,
//     title: 'Bigropy stories: A Journaling Workshop',
//     date: DateTime(2024, 9, 30),
//     time: '09:00 PM',
//     location: 'California, CA',
//     price: Price(
//       premiumPrice: 100.0,
//       regularPrice: 90.0,
//     ),
//     description: 'Join us for a journaling workshop where you can explore your creativity and express yourself.',
//     organizer: Organizer(
//       name: 'Bigropy',
//       verified: true,
//       logoUrl: defaultImageUrl,
//       category: 'Workshop',
//     ),
//     agenda: [
//       AgendaItem(
//         title: 'Introduction to Journaling',
//         speaker: 'Jane Doe',
//         startTime: '09:00 PM',
//         endTime: '09:30 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//       AgendaItem(
//         title: 'Interactive Session',
//         speaker: 'John Smith',
//         startTime: '09:30 PM',
//         endTime: '10:00 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//     ],
//     images: [
//       Image(url: 'https://wallpapers.com/images/hd/banner-background-b5a2ptzqzslvvuvv.jpg'),
//     ],
//     videoUrl: defaultVideoUrl,
//     ticketsLeft: 50,
//     category: 'Workshop',
//   ),
//   Event(
//     id: 2,
//     title: 'Creative self care: Guide to Intuitive Watercolor',
//     date: DateTime(2024, 10, 1),
//     time: '09:00 PM',
//     location: 'New York, NY',
//     price: Price(
//       premiumPrice: 25.90,
//       regularPrice: 20.00,
//     ),
//     description: 'Learn the art of intuitive watercolor painting in this creative self-care session.',
//     organizer: Organizer(
//       name: 'Creative Arts',
//       verified: true,
//       logoUrl: defaultImageUrl,
//       category: 'Art',
//     ),
//     agenda: [
//       AgendaItem(
//         title: 'Introduction to Watercolor',
//         speaker: 'Alice Johnson',
//         startTime: '09:00 PM',
//         endTime: '09:30 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//       AgendaItem(
//         title: 'Hands-on Practice',
//         speaker: 'Bob Brown',
//         startTime: '09:30 PM',
//         endTime: '10:00 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//     ],
//     images: [
//       Image(url: 'https://wallpapers.com/images/hd/banner-background-b5a2ptzqzslvvuvv.jpg'),
//     ],
//     videoUrl: defaultVideoUrl,
//     ticketsLeft: 75,
//     category: 'Art',
//   ),
// ];

// List<Event> suggestedEvents = [
//   Event(
//     id: 3,
//     title: 'Graphic Design Swalla Bigger Event For Creators',
//     date: DateTime(2024, 10, 10),
//     time: '09:00 PM',
//     location: 'Brooklyn, NY',
//     price: Price(
//       premiumPrice: 78.90,
//       regularPrice: 65.00,
//     ),
//     description: 'A grand event for graphic designers to showcase their talents and learn from the best.',
//     organizer: Organizer(
//       name: 'Swalla Designs',
//       verified: true,
//       logoUrl: defaultImageUrl,
//       category: 'Design',
//     ),
//     agenda: [
//       AgendaItem(
//         title: 'Keynote Speech',
//         speaker: 'David Lee',
//         startTime: '09:00 PM',
//         endTime: '09:30 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//       AgendaItem(
//         title: 'Panel Discussion',
//         speaker: 'Various',
//         startTime: '09:30 PM',
//         endTime: '10:00 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//     ],
//     images: [
//       Image(url: 'https://wallpapers.com/images/hd/banner-background-b5a2ptzqzslvvuvv.jpg'),
//     ],
//     videoUrl: defaultVideoUrl,
//     ticketsLeft: 100,
//     category: 'Design',
//   ),
//   Event(
//     id: 34,
//     title: 'Graphic Design Swalla Bigger Event For Creators',
//     date: DateTime(2024, 10, 10),
//     time: '09:00 PM',
//     location: 'Brooklyn, NY',
//     price: Price(
//       premiumPrice: 78.90,
//       regularPrice: 65.00,
//     ),
//     description: 'A grand event for graphic designers to showcase their talents and learn from the best.',
//     organizer: Organizer(
//       name: 'Swalla Designs',
//       verified: true,
//       logoUrl: defaultImageUrl,
//       category: 'Design',
//     ),
//     agenda: [
//       AgendaItem(
//         title: 'Keynote Speech',
//         speaker: 'David Lee',
//         startTime: '09:00 PM',
//         endTime: '09:30 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//       AgendaItem(
//         title: 'Panel Discussion',
//         speaker: 'Various',
//         startTime: '09:30 PM',
//         endTime: '10:00 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//     ],
//     images: [
//       Image(url: 'https://wallpapers.com/images/hd/banner-background-b5a2ptzqzslvvuvv.jpg'),
//     ],
//     videoUrl: defaultVideoUrl,
//     ticketsLeft: 100,
//     category: 'Design',
//   ),
//   Event(
//     id: 43,
//     title: 'Graphic Design Swalla Bigger Event For Creators',
//     date: DateTime(2024, 10, 10),
//     time: '09:00 PM',
//     location: 'Brooklyn, NY',
//     price: Price(
//       premiumPrice: 78.90,
//       regularPrice: 65.00,
//     ),
//     description: 'A grand event for graphic designers to showcase their talents and learn from the best.',
//     organizer: Organizer(
//       name: 'Swalla Designs',
//       verified: true,
//       logoUrl: defaultImageUrl,
//       category: 'Design',
//     ),
//     agenda: [
//       AgendaItem(
//         title: 'Keynote Speech',
//         speaker: 'David Lee',
//         startTime: '09:00 PM',
//         endTime: '09:30 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//       AgendaItem(
//         title: 'Panel Discussion',
//         speaker: 'Various',
//         startTime: '09:30 PM',
//         endTime: '10:00 PM',
//         speakerImageUrl: defaultImageUrl,
//       ),
//     ],
//     images: [
//       Image(url: 'https://wallpapers.com/images/hd/banner-background-b5a2ptzqzslvvuvv.jpg'),
//     ],
//     videoUrl: defaultVideoUrl,
//     ticketsLeft: 100,
//     category: 'Design',
//   ),
// ];




// // Sample Users