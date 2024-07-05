import 'package:flutter/material.dart';
import 'package:ticketron/models/formal.dart';
import 'package:ticketron/screens/organizer_screens/attendance_screen.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/organizer_view_widgets/organizer_event_card.dart'; 

class OrganizerDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Dashboard', style: TextStyle(fontSize: 18.0)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // notification handling
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // SizedBox(height: 20.0), 
            Text(
              'Current Events',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
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
            SizedBox(height: 20.0),
            Text(
              'Statistics',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
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

                SizedBox(width: 16.0),
                _buildStatisticCard(
                  context,
                  title: 'Past',
                  count: dummyEvents.where((event) => event.date.isBefore(DateTime.now())).length,
                ),
                 SizedBox(width: 16.0),
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
        currentIndex: 0, // Set initial index as needed
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
              // Navigate to Profile screen
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
      padding: EdgeInsets.all(8.0),
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
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 8.0),
          Text(
            '$count',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
