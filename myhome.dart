// myhomeapp.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyHomeApp extends StatefulWidget {
  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedActivity = "Wake up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Select Date:'),
            CustomDatePicker(),
            SizedBox(height: 16),
            Text('Select Time:'),
            ElevatedButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (pickedTime != null && pickedTime != selectedTime)
                  setState(() {
                    selectedTime = pickedTime;
                  });
              },
              child: Text('${selectedTime.format(context)}'),
            ),
            SizedBox(height: 16),
            Text('Select Activity:'),
            DropdownButton<String>(
              value: selectedActivity,
              items: <String>[
                'Wake up',
                'Go to gym',
                'Breakfast',
                'Meetings',
                'Lunch',
                'Quick nap',
                'Go to library',
                'Dinner',
                'Go to sleep'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedActivity = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Schedule the reminder (you'll have to implement the scheduling logic)
                print('Reminder set for $selectedDate at ${selectedTime.format(context)} to $selectedActivity');
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatefulWidget {
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat.yMMMd().format(selectedDate)),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null && pickedDate != selectedDate)
              setState(() {
                selectedDate = pickedDate;
              });
          },
          child: Text('Select date'),
        ),
      ],
    );
  }
}