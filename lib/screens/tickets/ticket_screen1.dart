// import 'package:flutter/material.dart';
// import 'package:ticketron/models/event_model.dart';
// import 'package:ticketron/models/ticket_model.dart';
// import 'package:ticketron/utils/constants.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ticketron/utils/dummydata.dart';

// class TicketsScreen extends StatefulWidget {
//   @override
//   _TicketsScreenState createState() => _TicketsScreenState();
// }

// class _TicketsScreenState extends State<TicketsScreen> {
//   int _selectedTabIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tickets'),
//       ),
//       body: Column(
//         children: [
//           DatePicker(),
//           SizedBox(height: Constants.paddingSmall),
//           TabBarSection(
//             selectedIndex: _selectedTabIndex,
//             onTabSelected: (index) {
//               setState(() {
//                 _selectedTabIndex = index;
//               });
//             },
//           ),
//           Expanded(
//             child: _selectedTabIndex == 0
//                 ? TicketList(tickets: tickets.where((t) => t.status == 'Upcoming').toList())
//                 : TicketList(tickets: tickets.where((t) => t.status == 'Past').toList()),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DatePicker extends StatefulWidget {
//   @override
//   _DatePickerState createState() => _DatePickerState();
// }

// class _DatePickerState extends State<DatePicker> {
//   int _selectedIndex = 0;

//   final List<DateTime> _dates = List<DateTime>.generate(
//     7,
//     (i) => DateTime.now().add(Duration(days: i)),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 80,
//       padding: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _dates.length,
//         itemBuilder: (context, index) {
//           final date = _dates[index];
//           final isSelected = index == _selectedIndex;

//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             child: Container(
//               width: 60,
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 color: isSelected ? Constants.primaryColor : Colors.transparent,
//                 borderRadius: BorderRadius.circular(Constants.borderRadius),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     _getMonthName(date.month),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     date.day.toString(),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     _getWeekDayName(date.weekday),
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     List<String> monthNames = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return monthNames[month - 1];
//   }

//   String _getWeekDayName(int weekday) {
//     List<String> weekDayNames = [
//       'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
//     ];
//     return weekDayNames[weekday - 1];
//   }
// }

// class TabBarSection extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTabSelected;

//   TabBarSection({required this.selectedIndex, required this.onTabSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildTab(text: 'Upcoming', index: 0),
//         const SizedBox(width: Constants.paddingLarge),
//         _buildTab(text: 'Past ticket', index: 1),
//       ],
//     );
//   }

//   Widget _buildTab({required String text, required int index}) {
//     final bool isSelected = index == selectedIndex;

//     return GestureDetector(
//       onTap: () => onTabSelected(index),
//       child: Column(
//         children: [
//           Text(
//             text,
//             style: TextStyle(
//               color: isSelected ? Constants.primaryColor : Colors.grey,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: Constants.paddingSmall),
//           if (isSelected)
//             Container(
//               width: 40,
//               height: 2,
//               color: Constants.primaryColor,
//             ),
//         ],
//       ),
//     );
//   }
// }

// class TicketList extends StatelessWidget {
//   final List<Ticket> tickets;

//   TicketList({required this.tickets});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(Constants.paddingMedium),
//       itemCount: tickets.length,
//       itemBuilder: (context, index) {
//         final ticket = tickets[index];
//         return TicketCard(ticket: ticket);
//       },
//     );
//   }
// }

// class TicketCard extends StatelessWidget {
//   final Ticket ticket;

//   TicketCard({required this.ticket});

//   @override
//   Widget build(BuildContext context) {
//     final event = events.firstWhere((e) => e.id == ticket.eventId);

//     return Container(
//       margin: const EdgeInsets.only(bottom: Constants.paddingMedium),
//       padding: const EdgeInsets.all(Constants.paddingMedium),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(Constants.borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CachedNetworkImage(
//                 imageUrl: event.images.isNotEmpty
//                     ? event.images[0].url
//                     : 'https://avatars.githubusercontent.com/u/79936608?v=4',
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(width: Constants.paddingMedium),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     event.title,
//                     style: Constants.heading3,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: Constants.paddingSmall),
//                   Row(
//                     children: [
//                       Icon(Icons.access_time, size: 16, color: Colors.grey),
//                       const SizedBox(width: Constants.paddingSmall),
//                       Text(
//                         '${event.date.day} ${_getMonthName(event.date.month)} ${event.date.year}',
//                         style: Constants.bodyText,
//                       ),
//                       const SizedBox(width: Constants.paddingMedium),
//                       Text(
//                         ticket.seat,
//                         style: TextStyle(color:Constants.greyColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: Constants.paddingSmall),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${ticket.ticketType} ticket x${ticket.quantity}',
//                 style: Constants.secondaryBodyText,
//               ),
//               SvgPicture.asset(
//                 'icons/${ticket.status == 'Past' ? 'zoom' : 'qrcode'}.svg',
//                 height: 24,
//                 width: 24,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _getMonthName(int month) {
//     List<String> monthNames = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     return monthNames[month - 1];
//   }
// }



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/dummydata.dart';
import 'package:ticketron/utils/helpers.dart';

class TicketsScreen extends StatefulWidget {
  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  int _selectedTabIndex = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Ticket> upcomingTickets = tickets.where((ticket) => ticket.status == "Upcoming").toList();
    List<Ticket> pastTickets = tickets.where((ticket) => ticket.status == "Past").toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
      ),
      body: Column(
        children: [
          _buildDatePicker(),
          _buildTabBar(),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildTicketList(upcomingTickets)
                : _buildTicketList(pastTickets),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          bool isSelected = date.day == _selectedDate.day;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Constants.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getMonthName(date.month),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getWeekDayName(date.weekday),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedTabIndex = 0;
              });
            },
            child: Column(
              children: [
                Text(
                  'Upcoming',
                  style: TextStyle(
                    color: _selectedTabIndex == 0 ? Constants.primaryColor : Colors.grey,
                    fontWeight: _selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (_selectedTabIndex == 0)
                  Container(
                    height: 2,
                    width: 60,
                    color: Constants.primaryColor,
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedTabIndex = 1;
              });
            },
            child: Column(
              children: [
                Text(
                  'Past ticket',
                  style: TextStyle(
                    color: _selectedTabIndex == 1 ? Constants.primaryColor : Colors.grey,
                    fontWeight: _selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (_selectedTabIndex == 1)
                  Container(
                    height: 2,
                    width: 60,
                    color: Constants.primaryColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketList(List<Ticket> tickets) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return _buildTicketCard(tickets[index]);
      },
    );
  }

  Widget _buildTicketCard(Ticket ticket) {
    Event event = events.firstWhere((e) => e.id == ticket.eventId);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            imageUrl:event.images[0].url,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          event.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4.0),
            Row(
              children: [
                Icon(Icons.access_time, size: 16.0, color: Colors.grey),
                const SizedBox(width: 4.0),
                Text(event.time),
                const SizedBox(width: 16.0),
                Icon(Icons.event_seat, size: 16.0, color: Colors.grey),
                const SizedBox(width: 4.0),
                Text(ticket.seat),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ticket.ticketType + ' ticket x${ticket.quantity}'),
                if (ticket.status == "Upcoming")
                  Icon(Icons.pending_actions, color: Constants.primaryColor)
                else
                  Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
