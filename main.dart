 // main.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ReminderApp());

// ignore: use_key_in_widget_constructors
class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedActivity;

  final List<String> _activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Set a Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker
            ListTile(
              title: Text(
                _selectedDate == null
                    ? 'No date chosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
              ),
              // ignore: prefer_const_constructors
              trailing: Icon(Icons.calendar_today),
              onTap: _presentDatePicker,
            ),
            // Time Picker
            ListTile(
              title: Text(
                _selectedTime == null
                    ? 'No time chosen!'
                    : 'Picked Time: ${_selectedTime!.format(context)}',
              ),
              // ignore: prefer_const_constructors
              trailing: Icon(Icons.access_time),
              onTap: _presentTimePicker,
            ),
            // Activity Dropdown
            DropdownButton<String>(
              // ignore: prefer_const_constructors
              hint: Text('Select Activity'),
              value: _selectedActivity,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedActivity = newValue;
                });
              },
              items: _activities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleReminder,
              // ignore: prefer_const_constructors
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }

  void _presentDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _selectedDate = picked;
      });
  }

  void _presentTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        _selectedTime = picked;
      });
  }

  void _scheduleReminder() {
    if (_selectedDate == null || _selectedTime == null || _selectedActivity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        // ignore: prefer_const_constructors
        SnackBar(content: Text('Please select date, time, and activity')),
      );
      return;
    }

    // Combine date and time into a DateTime object
    final DateTime scheduledDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    // TODO: Implement scheduling logic using flutter_local_notifications
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Reminder set for ${DateFormat.yMd().format(scheduledDateTime)} at ${_selectedTime!.format(context)} for $_selectedActivity'),
      ),
    );
  }
}