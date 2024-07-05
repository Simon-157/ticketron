import 'package:flutter/material.dart';
import 'package:ticketron/models/formal.dart';

class AttendanceListWidget extends StatelessWidget {
  final List<User> attendees;

  AttendanceListWidget({required this.attendees});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Attendance List',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: attendees.length,
            itemBuilder: (context, index) {
              User attendee = attendees[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(attendee.avatarUrl),
                ),
                title: Text(attendee.name),
                subtitle: Text(attendee.email),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              );
            },
          ),
        ],
      ),
    );
  }
}
