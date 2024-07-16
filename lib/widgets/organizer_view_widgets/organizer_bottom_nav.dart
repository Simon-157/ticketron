// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/screens/organizer_screens/attendance_screen.dart';
import 'package:ticketron/screens/organizer_screens/event_creation_screen.dart';
import 'package:ticketron/screens/organizer_screens/organizer_dashboard.dart';

// ignore: must_be_immutable
class OrganizerBottomNav extends StatelessWidget {
  Organizer? organizer;
  int currentIndex;

    OrganizerBottomNav({
    super.key,
     this.organizer,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
        currentIndex: currentIndex, 
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OrganizerDashboardScreen() )); 
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
      );
  }
}
