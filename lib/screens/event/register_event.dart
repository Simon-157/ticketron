import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/screens/event/order_screen.dart';
import 'package:ticketron/utils/constants.dart';

class ContactInformationScreen extends StatefulWidget {
  final int totalPrice;
  final Event event;


  ContactInformationScreen({required this.totalPrice, required this.event});
  

  @override
  _ContactInformationScreenState createState() => _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _phone = '';
  bool _receiveUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Information'),
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
                      offset: Offset(3, 3),
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
                    ),
                    const SizedBox(height: Constants.paddingMedium),
                    _buildTextField(
                      label: 'Email Address',
                      icon: Icons.email,
                      onSaved: (value) => _email = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter your email address' : null,
                    ),
                    const SizedBox(height: Constants.paddingMedium),
                    _buildTextField(
                      label: 'Mobile Phone',
                      icon: Icons.phone,
                      onSaved: (value) => _phone = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
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
        Expanded(
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Use the collected data for registration or other logic
      print('Full Name: $_fullName');
      print('Email: $_email');
      print('Phone: _$_phone');
      print('Receive Updates: $_receiveUpdates');

      // Navigate to confirmation page or show a success message
      // Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered successfully!')),
      );

      // Navigate to OrderDetails page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailOrderScreen(event: widget.event,)),
      );
    }
  }
}
