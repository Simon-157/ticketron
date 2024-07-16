
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticketron/models/event_model.dart'; 
import 'package:ticketron/models/organizer_model.dart';
import 'package:ticketron/screens/organizer_screens/event_create_screen_2.dart';
import 'package:ticketron/services/storage_service.dart'; 

class EventCreationScreen extends StatefulWidget {
  final Organizer? organizer;

  EventCreationScreen({Key? key, required this.organizer}) : super(key: key);

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImageUploadService _imageUploadService = ImageUploadService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _premiumPriceController = TextEditingController();
  TextEditingController _regularPriceController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<String> _imageUrls = [];
  List<File> _imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
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
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 20.0),
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
            
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _buildTextField(
                      keyboardType: TextInputType.number,
                      labelText: 'Premium Price',
                      controller: _premiumPriceController,),
                  ),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: _buildTextField(
                      controller: _regularPriceController,
                      keyboardType: TextInputType.number,
                      labelText: 'Regular Price',
                    
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              _buildImagePicker(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Event newEvent = Event(
                      eventId: DateTime.now().millisecondsSinceEpoch.toString() + widget.organizer!.organizerId,
                      title: _titleController.text.trim(),
                      date: _selectedDate,
                      time: '${_selectedTime.hour}:${_selectedTime.minute}',
                      location: _locationController.text.trim(),
                      price: Price(
                        premiumPrice: double.parse(_premiumPriceController.text.trim()),
                        regularPrice: double.parse(_regularPriceController.text.trim()),
                      ),
                      description: _descriptionController.text.trim(),
                      organizer: widget.organizer,
                      agenda: [], 
                      images: _imageUrls, 
                      ticketsLeft: 100, 
                      category: 'General', 
                      totalCapacityNeeded: 0,
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventCategoryScreen(event: newEvent),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, 
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Next',
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
        labelStyle: const TextStyle(color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
      style: const TextStyle(fontSize: 14.0),
    );
  }

  Widget _buildButton({required VoidCallback onPressed, required String label}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Event Images',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        _imageFiles.isNotEmpty
            ? Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: _imageFiles.map((file) {
                  return Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          file,
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _imageFiles.remove(file);
                            });
                          },
                          child: const CircleAvatar(
                            radius: 12.0,
                            backgroundColor: Colors.red,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )
            : ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, 
                  padding: const EdgeInsets.symmetric(vertical: 15.0), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), 
                  ),
                ),
                child: const Text(
                  'Pick Images',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
      ],
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _pickImage() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 70);
    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      });

      for (final file in _imageFiles) {
        _imageUrls.add(await _imageUploadService.uploadImage(file));
      }
    }

    print(_imageUrls);
    
  }
}
