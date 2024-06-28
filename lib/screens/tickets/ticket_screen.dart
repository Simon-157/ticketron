import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/dummydata.dart';
import 'package:ticketron/utils/helpers.dart';
import 'package:ticketron/widgets/tickets/tab_bar.dart';
import 'package:ticketron/widgets/tickets/ticketcard.dart';

class TicketsScreen extends StatefulWidget {
  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  int _selectedIndex = 0;

  List<Ticket> get filteredTickets {
    if (_selectedIndex == 0) {
      return tickets.where((ticket) => ticket.status == "Upcoming").toList();
    } else {
      return tickets.where((ticket) => ticket.status == "Past").toList();
    }
  }

  Event getEventForTicket(int eventId) {
    return events.firstWhere((event) => event.id == eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tickets'),
      ),
      body: Column(
        children: [
          DatePicker(),
          CustomTabBar(
            tabs: ['Upcoming', 'Past ticket'],
            selectedIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, index) {
                Ticket ticket = filteredTickets[index];
                Event event = getEventForTicket(ticket.eventId);
                return TicketCard(
                  eventTitle: event.title,
                  time: event.time,
                  seat: ticket.seat,
                  ticketType: ticket.ticketType,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int _selectedIndex = 0;

  final List<DateTime> _dates = List<DateTime>.generate(
    7,
    (i) => DateTime.now().add(Duration(days: i)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(Constants.paddingSmall),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
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

}
