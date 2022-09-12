import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    Key? key,
    this.selectedDate,
    required this.onDatePicked,
  }) : super(key: key);

  final DateTime? selectedDate;
  final Function(DateTime?) onDatePicked;

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      onDatePicked(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2018),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDatePicked,
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(selectedDate != null
                      ? 'Selected date: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}'
                      : 'No selected date!'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () => _showDatePicker(context),
                  child: const Text(
                    'Select date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
