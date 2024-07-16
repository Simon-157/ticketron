import 'package:flutter/material.dart';
import 'package:ticketron/models/event_model.dart';
import 'package:ticketron/services/event_service.dart'; // Assuming Event and AgendaItem models are defined here

class EventCategoryScreen extends StatefulWidget {
  final Event event;

  EventCategoryScreen({required this.event});

  @override
  _EventCategoryScreenState createState() => _EventCategoryScreenState();
}

class _EventCategoryScreenState extends State<EventCategoryScreen> {
    final EventService _eventService = EventService();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _totalCapacityController = TextEditingController();
  List<AgendaItem> _agendaItems = [];
    DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildButton(
                    onPressed: _selectDate,
                    label: 'Select Date',
                  ),
                  _buildButton(
                    onPressed: _selectTime,
                    label: 'Select Time',
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                  Text(
                    'Time: ${_selectedTime.format(context)}',
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ],
              ),
              _buildAgendaSection(),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _submitDetails,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      ),
    );
  }

  Widget _buildAgendaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Agenda',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _agendaItems.length,
          itemBuilder: (context, index) {
            final item = _agendaItems[index];
            return ListTile(
              title: Text(item.title),
              subtitle: Text('Speaker: ${item.speaker}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _agendaItems.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: _addAgendaItem,
          child: const Text('Add Agenda Item'),
        ),
      ],
    );
  }

  void _addAgendaItem() {
    showDialog(
      context: context,
      builder: (context) {
        final _titleController = TextEditingController();
        final _speakerController = TextEditingController();
        final _startTimeController = TextEditingController();
        final _endTimeController = TextEditingController();
        final _speakerImageUrlController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Agenda Item'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(controller: _titleController, labelText: 'Title'),
                const SizedBox(height: 10.0),
                _buildTextField(controller: _speakerController, labelText: 'Speaker'),
                const SizedBox(height: 10.0),
                _buildTextField(controller: _startTimeController, labelText: 'Start Time'),
                const SizedBox(height: 10.0),
                _buildTextField(controller: _endTimeController, labelText: 'End Time'),
                const SizedBox(height: 10.0),
                _buildTextField(controller: _speakerImageUrlController, labelText: 'Speaker Image URL'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _agendaItems.add(AgendaItem(
                    title: _titleController.text,
                    speaker: _speakerController.text,
                    startTime: _startTimeController.text,
                    endTime: _endTimeController.text,
                    speakerImageUrl: _speakerImageUrlController.text,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
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

  void _submitDetails() async{
    if (_formKey.currentState!.validate()) {
      widget.event.category = _categoryController.text.trim();
      widget.event.totalCapacityNeeded = int.parse(_totalCapacityController.text.trim());
      widget.event.agenda = _agendaItems;


      try {
        await _eventService.createEvent(widget.event);
        showSnackbar(context, "Event created successfully");
        // _formKey.currentState!.reset();
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(title: Text(e.toString()),));
      }

      // Navigator.of(context).pop();
      // Navigator.of(context).pop();
    }
  }



  void showSnackbar(BuildContext context, String message) {
    final snackBar = 
      
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16, color: Colors.white)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 201, 101),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }



}

