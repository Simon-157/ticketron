import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/attendance_model.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/order_screen.dart';
import 'package:ticketron/services/attendance_service.dart';
import 'package:ticketron/services/auth_service.dart';
import 'package:ticketron/utils/constants.dart';

class ContactInformationScreen extends StatefulWidget {
  final int totalPrice;
  final int quantity;
  final String ticketType;
  final Event event;

  const ContactInformationScreen({super.key, required this.totalPrice, required this.event, required this.quantity, required this.ticketType});
  
  @override
  _ContactInformationScreenState createState() => _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  AuthService _authService = AuthService();
  EventAttendanceService _attendanceService = EventAttendanceService();
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _phone = ''; 
  String _userId = '';
  bool _receiveUpdates = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
   }

   void _getUserData() async {
    final userData = await _authService.getUserData();
    setState(() {
      _fullName = userData?.name ?? '';
      _email = userData?.email ?? '';
      _userId = userData?.userId ?? '';
    });
  }

  void _shareQRCode() {
    //TODO: Logic for sharing the QR code by displaying a modal with options to share on all social media platforms and option to copy the code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Event'),
         centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Logic for sharing the QR code
            },
            icon:  SvgPicture.asset(
              CustomIcons.menuVertical,
              height: 24,
            ),
          ),],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.paddingLarge),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(Constants.paddingLarge),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(3, 3),
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Full Name',
                      icon: Icons.person,
                      onSaved: (value) => _fullName = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
                      initialValue: _fullName,
                      isDisabled: false,
                    ),
                    const SizedBox(height: Constants.paddingMedium),
                    _buildTextField(
                      label: 'Email Address',
                      icon: Icons.email,
                      onSaved: (value) => _email = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter your email address' : null,
                      initialValue: _email,
                      isDisabled: false,
                    ),
                    const SizedBox(height: Constants.paddingMedium),
                    _buildTextField(
                      label: 'Mobile Phone',
                      icon: Icons.phone,
                      onSaved: (value) => _phone = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                      initialValue: '+1 234 567 890',
                      isDisabled: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Constants.paddingLarge),
              _buildUpdatesCheckbox(),
              const SizedBox(height: Constants.paddingLarge),
              _buildAgreementText(),
              const SizedBox(height: Constants.paddingLarge),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomSection(),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    required String initialValue,
    required isDisabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Constants.bodyText.copyWith(color: Colors.black54),
        ),
        const SizedBox(height: Constants.paddingSmall),
        TextFormField(
          enabled: !isDisabled,
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black54),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildUpdatesCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _receiveUpdates,
          onChanged: (value) {
            setState(() {
              _receiveUpdates = value!;
            });
          },
        ),
        const Expanded(
          child: Text(
            'Keep me updated on the latest news, events, and the exclusive offers on this event organizer.',
            style: Constants.bodyText,
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementText() {
    return Text(
      'By clicking “Register”, I accept the Terms of Service and have read Privacy Policy. I agree that Eventline may share my information with the event organizer.',
      style: Constants.bodyText.copyWith(fontSize: 12),
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\$${widget.totalPrice}',
            style: Constants.heading3.copyWith(color: Constants.primaryColor),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }

  String _generateRandomId() {
    const idLength = 8;
    final random = Random();
    final id = List<int>.generate(idLength, (_) => random.nextInt(36)).map((i) => '0123456789ABCDEFHJKMNPRTVWXYZ'[i]).join();
    return id.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)}-");
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
      return;
    }

    _formKey.currentState!.save();

    final attendanceData = EventAttendance(
      eventId: widget.event.eventId, 
      userId: _userId, 
      attendanceId: _generateRandomId(), 
      paymentStatus: PaymentStatus.notPaid, 
      attendanceStatus: AttendanceStatus.notAttended,
      timestamp: DateTime.now(),
    );

    try {
      final attendanceId = await _attendanceService.createAttendance(attendanceData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered successfully!')),
      );

      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailOrderScreen(
          event: widget.event, 
          totalPrice: widget.totalPrice, 
          ticketType: widget.ticketType, 
          quantity: widget.quantity, 
          phone: _phone, 
          email: _email, 
          attendanceId: attendanceId,
        )),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register: $error')),
      );
    }
  }
}

