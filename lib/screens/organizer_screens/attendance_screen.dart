import 'package:flutter/material.dart';
import 'package:ticketron/models/attendance_model.dart';
import 'package:ticketron/models/user_model.dart';
import 'package:ticketron/services/attendance_service.dart';
import 'package:ticketron/services/ticket_service.dart';
import 'package:ticketron/services/user_service.dart';
import 'package:ticketron/widgets/organizer_view_widgets/barcode_scanner_widget.dart';
import 'package:ticketron/widgets/organizer_view_widgets/qr_code_scanner_widget.dart';

class AttendanceScreen extends StatefulWidget {
  final String eventId;
  const AttendanceScreen({super.key, required this.eventId});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  List<UserModel> users = [];
  
  bool isLoading = true;
  bool hasError = false;
  String searchQuery = '';
  AttendanceStatus? selectedAttendanceStatus;
  UserService _userService = UserService();
  PaymentStatus? selectedPaymentStatus;
  final TicketService _ticketService = TicketService();
   final service = EventAttendanceService();

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
   
    try {
      List<Map<String, dynamic>> attendanceList = await service.getAttendanceListForEvent(widget.eventId);
      
      // Filter the data
      var filteredList = attendanceList.where((data) {
        final user = UserModel.fromMap(data);
        final matchesSearchQuery = user.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesAttendanceStatus = selectedAttendanceStatus == null || data['attendanceStatus'] == selectedAttendanceStatus!.index;
        final matchesPaymentStatus = selectedPaymentStatus == null || data['paymentStatus'] == selectedPaymentStatus!.index;
        return matchesSearchQuery && matchesAttendanceStatus && matchesPaymentStatus;
      }).toList();
      
      setState(() {
        users = filteredList.map((data) => UserModel.fromMap(data)).toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print('Failed to load attendance data: $error');
    }
  }

  void handleBarcodeDetected(String code) async {
    print('Barcode detected: $code');
    try {
      final ticket = await _ticketService.verifyTicketByBarcode(code);
      final user = await _userService.getUser(ticket.userId);
      _showMessageModal('Ticket Verified', 'Ticket ID: ${ticket.barcode}\nUser: ${user?.name}');
    } catch (error) {
      _showMessageModal('Verification Failed', 'The barcode could not be verified.');
    }
  }

  Future<bool> handleQRCodeDetected(String code) async {
    print('QR code detected: $code');
    try {
      final ticket = await _ticketService.verifyTicket(code);
       service.updateAttendanceByUserIdAndEventId(ticket.eventId, ticket.userId);
      _showMessageModal('Ticket Verified', 'Ticket ID: ${ticket.qrcode}\nUser: username');
      return true;
    } catch (error) {
      print(error);
      _showMessageModal('Verification Failed', 'The QR code could not be verified.');
      return false;
    }
  }

  void _showMessageModal(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Attendance', style: TextStyle(fontSize: 18.0)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Failed to load data. Please try again later.'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildSearchAndFilterControls(),
                    _buildActionButtons(),
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

  Widget _buildSearchAndFilterControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40.0,
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  fetchAttendanceData();
                });
              },
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: DropdownButtonFormField<AttendanceStatus>(
                    value: selectedAttendanceStatus,
                    items: AttendanceStatus.values.map((status) {
                      return DropdownMenuItem<AttendanceStatus>(
                        value: status,
                        child: Text(status.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAttendanceStatus = value;
                        fetchAttendanceData();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Attend Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                flex: 1,
                child: Container(
                  // width: double.infinity,
                  child: DropdownButtonFormField<PaymentStatus>(
                    value: selectedPaymentStatus,
                    items: PaymentStatus.values.map((status) {
                      return DropdownMenuItem<PaymentStatus>(
                        value: status,
                        child: Text(status.toString().split('.').last),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentStatus = value;
                        fetchAttendanceData();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Pay Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
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
                print(continueScanning);
                if (continueScanning == false) {
                  setState(() {}); // Refresh UI after scanning completes
                }
              }).catchError((err){print(err);});
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'No attendance record found.',
          style: TextStyle(fontSize: 16.0),
        ),
      );
    }

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
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: NetworkImage(users[index].avatarUrl),
            ),
            title: Text(users[index].name, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            subtitle: Text(users[index].email, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   AttendanceStatus.values[users[index].attendanceStatus].toString().split('.').last,
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     fontWeight: FontWeight.bold,
                //     color: AttendanceStatus.values[users[index].attendanceStatus] == AttendanceStatus.present ? Colors.green : Colors.red,
                //   ),
                // ),
                // const SizedBox(height: 4.0),
                // Text(
                //   PaymentStatus.values[users[index].paymentStatus].toString().split('.').last,
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     fontWeight: FontWeight.bold,
                //     color: PaymentStatus.values[users[index].paymentStatus] == PaymentStatus.paid ? Colors.green : Colors.red,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
