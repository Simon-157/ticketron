import 'package:flutter/material.dart';
import 'package:ticketron/models/user_model.dart';
import 'package:ticketron/utils/organizer_data.dart';
import 'package:ticketron/widgets/organizer_view_widgets/barcode_scanner_widget.dart';
import 'package:ticketron/widgets/organizer_view_widgets/qr_code_scanner_widget.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<UserModel> users = usersData;
  void handleBarcodeDetected(String code) {
    print('Barcode detected: $code');
    // Simulate fetching user details from a database or API
    UserModel user = UserModel(
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
    UserModel user = UserModel(
      name: 'Jane Smith',
      email: 'jane.smith@example.com',
      avatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
      userId: '3456',
    );
    registerAttendee(user);

    await Future.delayed(const Duration(seconds: 2)); // Simulate API call or processing time

    return true;
  }

  void registerAttendee(UserModel attendee) {
    setState(() {
      users.add(attendee);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Attendance', style: TextStyle(fontSize: 18.0)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildActionButtons(), // Custom styled action buttons
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Text(
                    'Attendees',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _buildAttendeeList(),
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
      padding: const EdgeInsets.all(8.0),
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
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
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(height: 0.0, color: Colors.grey[300]),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(users[index].avatarUrl),
            ),
            title: Text(
              users[index].name,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              users[index].email,
              style: const TextStyle(fontSize: 14.0),
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
    );
  }
}
