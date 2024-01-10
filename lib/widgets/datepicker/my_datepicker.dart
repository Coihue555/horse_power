import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  const MyDatePicker({Key? key}) : super(key: key);

  @override
  MyDatePickerState createState() => MyDatePickerState();
}

class MyDatePickerState extends State<MyDatePicker> {
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Row(
        children: [
          TextField(
            controller: dateController,
            onChanged: (value) {
              updateSelectedDate(value);
            },
            decoration: const InputDecoration(
              constraints: BoxConstraints(maxWidth: 400),
              labelText: 'Select Date',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _selectDate(context);
            },
            child: const Icon(Icons.calendar_today),
          ),
        ],
      ),
    );
  }

  void updateSelectedDate(String value) {
    try {
      final DateFormat format = DateFormat('dd/MM/yyyy');
      final DateTime parsedDate = format.parse(value);
      setState(() {
        selectedDate = parsedDate;
      });
    } catch (e) {
      log('Invalid date format');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
}
