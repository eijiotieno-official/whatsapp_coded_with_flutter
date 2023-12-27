// Import necessary packages for Flutter
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define a function named 'formatTime' for formatting DateTime to a string
String formatTime({
  required DateTime
      dateTime, // Required parameter representing the date and time
  required BuildContext
      context, // Required parameter representing the build context
}) {
  // Retrieve the preferred time format (24-hour or 12-hour) based on the device's settings
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  // Use the 'DateFormat' class from the 'intl' package to format the DateTime
  String formattedTime = is24HoursFormat
      ? DateFormat.Hm().format(dateTime) // Use 24-hour format
      : DateFormat('h:mm a')
          .format(dateTime); // Use 12-hour format with AM/PM indicator

  // Return the formatted time as a string
  return formattedTime;
}
