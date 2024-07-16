import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/screens/organizer_screens/attendance_screen.dart';
import 'package:ticketron/screens/organizer_screens/event_creation_screen.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/organizer_view_widgets/organizer_event_card.dart'; 

class OrganizerDashboardScreen extends StatefulWidget {

  const OrganizerDashboardScreen({super.key});

  @override
  State<OrganizerDashboardScreen> createState() => _OrganizerDashboardScreenState();
}

class _OrganizerDashboardScreenState extends State<OrganizerDashboardScreen> with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  Organizer? organizer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _authService.getOrganizerDetails(_authService.getCurrentUser()!.uid).then((value) {
      setState(() {
        organizer = value;
      });
    });
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut,);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        // backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false, 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
               final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                      final Offset tapPosition = overlay.localToGlobal(Offset.zero);
                      _showPopupMenu(context, tapPosition);
            },
            
            child: CircleAvatar(
            radius: 10.0,
            backgroundImage: NetworkImage(organizer?.logoUrl ?? 'https://via.placeholder.com/150', scale: 0.1),

          ),
        )),
        title:  Text("${organizer?.name}'s Dashboard ", style: const TextStyle(fontSize: 18.0)),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
          tooltip: 'Notifications',
          icon: const Icon(Icons.notifications, color: Colors.blueAccent,),
          onPressed: () {
            // notification handling
          },
              ),
              Positioned(
          top: 12,
          right: 17,
          child: Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
              ),
            ],
          ),
        ],
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 20.0), 
            const Text(
              'Current Events',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 200.0, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyEvents.length,
                itemBuilder: (context, index) {
                  Event event = dummyEvents[index];
                  return buildEventCard(event);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Statistics',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildStatisticCard(
                  context,
                  title: 'Present',
                  count: dummyEvents.where((event) => event.date.isAfter(DateTime.now())).length,
                ),

                const SizedBox(width: 16.0),
                _buildStatisticCard(
                  context,
                  title: 'Past',
                  count: dummyEvents.where((event) => event.date.isBefore(DateTime.now())).length,
                ),
                 const SizedBox(width: 16.0),
                _buildStatisticCard(
                  context,
                  title: 'Audience',
                  count: dummyEvents.where((event) => event.date.isBefore(DateTime.now())).length,
                ),
              ],
            ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, 
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Event',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Revenue',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to Events screen
              break;
            case 1:
              // Navigate to Messages screen
              break;
            case 2:
              // Navigate to Add Event screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventCreationScreen( organizer: organizer) ));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen() ));
              break;
            default:
          }
        },
      ),
    );
  }

  Widget buildEventCard(Event event) {
    return OrganizerEventCard(event: event);
  }

  Widget _buildStatisticCard(context, {required String title, required int count}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 8.0),
          Text(
            '$count',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }


  void _showPopupMenu(BuildContext context, Offset tapPosition) {
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
