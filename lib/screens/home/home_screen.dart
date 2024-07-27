import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/services/events_services.dart';
import 'package:ticketron/utils/constants.dart';
import 'package:ticketron/widgets/home/filter_toggles_widget.dart';
import 'package:ticketron/widgets/home/searchbar_widget.dart';
import 'package:ticketron/widgets/home/suggestions_foryou_widget.dart';
import 'package:ticketron/widgets/home/upcoming_events_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  
  AuthService _authService = AuthService();
  EventService eventService = EventService();
  List<Event> filteredEvents = [];
  List<Event> allEvents = [];
  String searchQuery = '';
  String selectedCategory = 'All'; // Default to 'All'
  bool isLoading = true;
  String errorMessage = '';

  Future<void> _fetchEvents() async {
    try {
      List<Event> events = await eventService.getAllEvents(_authService.getCurrentUser()!.uid);
      setState(() {
        allEvents = events; 
        filteredEvents = allEvents;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching events: $e');
      setState(() {
        errorMessage = 'Failed to load events';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    eventService = EventService();
    _fetchEvents();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut,);
  }

  void _applyFilters(String key) {
    setState(() {
      switch (key) {
        case 'category':
          if (selectedCategory == 'All') {
            filteredEvents = allEvents;
          } else {
            filteredEvents = allEvents
                .where((event) => event.category.toLowerCase().contains(selectedCategory.toLowerCase()))
                .toList();
          }
          break;
        case 'search':
          if (searchQuery.isEmpty) {
            filteredEvents = allEvents;
          } else {
            filteredEvents = allEvents
                .where((event) => event.title.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();
          }
          break;
        default:
          filteredEvents = allEvents;
          break;
      }
    });
  }

  void _handleFilterChange(String category) {
    setState(() {
      selectedCategory = category == 'My Feed' ? 'All' : category;
      _applyFilters('category');
    });
  }

  void _showPopupMenu(BuildContext context, Offset tapPosition) {
    _controller.forward();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx + 100,
        tapPosition.dy + 100,
        0,
        0,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'settings',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'remove',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remove'),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _controller.reverse();
        if (value == 'logout') {
          _authService.signOut(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Constants.backgroundColor,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find events near you',
                style: TextStyle(
                  color: Color.fromARGB(90, 0, 0, 0),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      _authService.getCurrentUser()!.photoURL ?? 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  const Text(
                    'California, USA',
                    style: Constants.heading3,
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, color: Color.fromARGB(57, 0, 0, 0)),
                        onPressed: () {
                          // Logic for notification button
                        },
                      ),
                      Positioned(
                        right: 15,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(169, 247, 59, 1),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 8,
                            minHeight: 8,
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Color.fromARGB(57, 0, 0, 0)),
                    onPressed: () {
                      final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                      final Offset tapPosition = overlay.localToGlobal(Offset.zero);
                      _showPopupMenu(context, tapPosition);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchBox(),
                const SizedBox(height: Constants.paddingMedium),
                FilterToggles(onFilterChanged: _handleFilterChange),
                const SizedBox(height: Constants.paddingMedium),
                UpcomingEvents(events: filteredEvents), 
                const SizedBox(height: Constants.paddingLarge),
                const SuggestionsForYou(),
              ],
            ),
          ),
        ),
      ),
    );
  }




  void _showUserPopupMenu(BuildContext context, Offset tapPosition) {
    _controller.forward();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx ,
        tapPosition.dy + 70,
        0,
        0,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'settings',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: FadeTransition(
            opacity: _animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: const Offset(0, 0),
              ).animate(_animation),
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'remove',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remove'),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        _controller.reverse();
        if (value == 'logout') {
          _authService.signOut(context);
        }

      }
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
