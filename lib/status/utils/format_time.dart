// Import necessary packages for Flutter and date/time formatting
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define a function named formatTime for formatting date and time
String formatTime({
  required DateTime dateTime, // Required parameter for the input date and time
  required BuildContext
      context, // Required parameter for the Flutter build context
}) {
  // Retrieve whether the device's time format is set to 24-hour format
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  // Get the current date and time
  DateTime now = DateTime.now();
  // Create a DateTime object representing the current day
  DateTime today = DateTime(now.year, now.month, now.day);

  // Check if the provided dateTime is before today
  if (dateTime.isBefore(today)) {
    // If the provided dateTime is in the past, return "Yesterday"
    return 'Yesterday';
  } else {
    // If the provided dateTime is today, format the time accordingly
    String formattedTime = is24HoursFormat
        ? DateFormat.Hm().format(dateTime) // Use 24-hour format
        : DateFormat('h:mm a')
            .format(dateTime); // Use 12-hour format with AM/PM

    // Return a string indicating "Today" along with the formatted time
    return 'Today $formattedTime';
  }
}
