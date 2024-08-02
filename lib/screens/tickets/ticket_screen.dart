import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/ticket_model.dart';
import 'package:ticketron/screens/tickets/ticket_detailed_screen.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/services/ticket_service.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/utils/helpers.dart';
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
  final EventService _eventService = EventService();
  List<Ticket> _tickets = [];
  List<Ticket> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _fetchTickets();
  }

  Future<void> _fetchTickets() async {
    final userId = _authService.getCurrentUser()!.uid;
    final tickets = await _ticketService.listUserTickets(userId);
    print(tickets);
    setState(() {
      _tickets = tickets; //tickets;
      _filteredTickets = _filterTickets(tickets, _selectedIndex);
    });
  }

  List<Ticket> _filterTickets(List<Ticket> tickets, int selectedIndex) {
    final status = selectedIndex == 0 ? "active" : "in-active";
    return tickets.where((ticket) => ticket.status == status).toList();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedIndex = index;
      _filteredTickets = _filterTickets(_tickets, _selectedIndex);
    });
  }

  Future<Event> _getEventForTicket(String eventId) async {
    return await _eventService.getEventById(eventId);
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
          _filteredTickets.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      _selectedIndex == 0
                          ? 'No upcoming tickets'
                          : 'No past tickets',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _filteredTickets.length,
                    itemBuilder: (context, index) {
                      final ticket = _filteredTickets[index];
                      return FutureBuilder<Event>(
                        future: _getEventForTicket(ticket.eventId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error loading event data'),
                            );
                          } else if (!snapshot.hasData) {
                            return const Center(
                              child: Text('Event not found'),
                            );
                          } else {
                            final event = snapshot.data!;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TicketDetailScreen(ticket: ticket),
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
                          }
                        },
                      );
                    },
                  ),
                )
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
