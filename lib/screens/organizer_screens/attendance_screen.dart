import 'package:flutter/material.dart';
import 'package:ticketron/models/formal.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/organizer_view_widgets/barcode_scanner_widget.dart';
import 'package:ticketron/widgets/organizer_view_widgets/qr_code_scanner_widget.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<User> users = usersData;
  void handleBarcodeDetected(String code) {
    print('Barcode detected: $code');
    // Simulate fetching user details from a database or API
    User user = User(
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      userId: '3456',
    );
    registerAttendee(user);
  }

  Future<bool> handleQRCodeDetected(String code) async {
    print('QR code detected: $code');
    // Simulate fetching user details from a database or API
    User user = User(
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      userId: '3456',
    );
    registerAttendee(user);

    await Future.delayed(Duration(seconds: 2)); // Simulate API call or processing time

    return true;
  }

  void registerAttendee(User attendee) {
    setState(() {
      users.add(attendee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Attendance', style: TextStyle(fontSize: 18.0)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildActionButtons(), // Custom styled action buttons
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Attendees',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _buildAttendeeList(), // Aesthetically designed attendee list
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BarcodeScannerWidget(
                    onCodeDetected: handleBarcodeDetected,
                  ),
                ),
              ).then((_) {
                setState(() {}); // Refresh UI after scanning completes
              });
            },
            label: 'Scan Barcode',
          ),
          _buildCustomButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QRCodeScannerWidget(
                    onCodeDetected: handleQRCodeDetected,
                  ),
                ),
              ).then((continueScanning) {
                if (continueScanning == false) {
                  setState(() {}); // Refresh UI after scanning completes
                }
              });
            },
            label: 'Scan QR Code',
          ),
        ],
      ),
    );
  }

  Widget _buildCustomButton({required VoidCallback onPressed, required String label}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildAttendeeList() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(height: 0.0, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(users[index].avatarUrl),
            ),
            title: Text(
              users[index].name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              users[index].email,
              style: TextStyle(fontSize: 14.0),
            ),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
    );
  }
}
