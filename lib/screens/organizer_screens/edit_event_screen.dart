import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/event_service.dart'; // Import your event service

class EventEditScreen extends StatefulWidget {
  final Event event;

  EventEditScreen({required this.event});

  @override
  _EventEditScreenState createState() => _EventEditScreenState();
}

class _EventEditScreenState extends State<EventEditScreen> {
  final EventService _eventService = EventService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _premiumPriceController = TextEditingController();
  TextEditingController _regularPriceController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _totalCapacityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.event.title;
    _descriptionController.text = widget.event.description;
    _locationController.text = widget.event.location;
    _premiumPriceController.text = widget.event.price.premiumPrice.toString();
    _regularPriceController.text = widget.event.price.regularPrice.toString();
    _categoryController.text = widget.event.category;
    _totalCapacityController.text = widget.event.totalCapacityNeeded.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField(
                controller: _titleController,
                labelText: 'Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                controller: _descriptionController,
                labelText: 'Description',
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                controller: _locationController,
                labelText: 'Location',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildTextField(
                      keyboardType: TextInputType.number,
                      controller: _premiumPriceController,
                      labelText: 'Premium Price',
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: _buildTextField(
                      keyboardType: TextInputType.number,
                      controller: _regularPriceController,
                      labelText: 'Regular Price',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                controller: _categoryController,
                labelText: 'Category',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                controller: _totalCapacityController,
                labelText: 'Total Capacity Needed',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total capacity needed';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.event.title = _titleController.text.trim();
                    widget.event.description = _descriptionController.text.trim();
                    widget.event.location = _locationController.text.trim();
                    widget.event.price.premiumPrice = double.parse(_premiumPriceController.text.trim());
                    widget.event.price.regularPrice = double.parse(_regularPriceController.text.trim());
                    widget.event.category = _categoryController.text.trim();
                    widget.event.totalCapacityNeeded = int.parse(_totalCapacityController.text.trim());

                    _updateEvent(widget.event);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Update Event',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
    );
  }

  void _updateEvent(Event event) async {
    try {
      await _eventService.updateEvent(event);
      showSnackbar(context, "Event updated successfully");
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Color.fromARGB(255, 96, 201, 101),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
