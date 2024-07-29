import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/screens/tickets/ticket_detailed_screen.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/ticket_service.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/tickets/tab_bar.dart';
import 'package:ticketron/widgets/tickets/ticketcard.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  _TicketsScreenState createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();
  final TicketService _ticketService = TicketService();
  List<Ticket> _tickets = [];
  List<Ticket> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    final userId = _authService.getCurrentUser()!.uid;
    // final tickets = await _ticketService.listUserTickets(userId);
    setState(() {
      _tickets = tickets; //dummyTickets;
      _filteredTickets = _filterTickets(tickets, _selectedIndex);
    });
  }

  List<Ticket> _filterTickets(List<Ticket> tickets, int selectedIndex) {
    final status = selectedIndex == 0 ? "Upcoming" : "Past";
    return tickets.where((ticket) => ticket.status == status).toList();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _filteredTickets = _filterTickets(_tickets, _selectedIndex);
    });
  }

  Event _getEventForTicket(String eventId) {
    return dummyEvents.firstWhere((event) => event.eventId == eventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tickets'),
      ),
      body: Column(
        children: [
          const DatePicker(),
          CustomTabBar(
            tabs: const ['Active', 'In-Active'],
            selectedIndex: _selectedIndex,
            onTap: _onTabChanged,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = _filteredTickets[index];
                final event = _getEventForTicket(ticket.eventId);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketDetailScreen(ticket: ticket),
                      ),
                    );
                  },
                  child: TicketCard(
                    eventTitle: event.title,
                    time: event.time,
                    seat: ticket.seat,
                    ticketType: ticket.ticketType,
                  ),
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
  const DatePicker({Key? key}) : super(key: key);

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
