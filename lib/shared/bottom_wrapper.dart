import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ticketron/screens/explore/explore_screen.dart';
import 'package:ticketron/screens/home/home_screen.dart';
import 'package:ticketron/screens/organizer_screens/organizer_dashboard.dart';
import 'package:ticketron/screens/profile/profile_screen.dart';
import 'package:ticketron/screens/tickets/ticket_screen.dart';
import 'package:ticketron/shared/bottom_snake_bar.dart';



class BottomNavWrapper extends StatefulWidget {
  const BottomNavWrapper({super.key});

  @override
  State<BottomNavWrapper> createState() => _BottomNavWrapperState();
}

class _BottomNavWrapperState extends State<BottomNavWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions =  <Widget>[
     HomeScreen(),
     const ExploreScreen(),
     OrganizerDashboardScreen(),
     TicketsScreen(),
     const ProfileScreen(),
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomSnakeBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
      ).animate().fade(duration: 850.ms).slideY(
            begin: 0.5,
            duration: 850.ms,
            curve: Curves.easeInOutCubic,
          ),
    );
  }
}
