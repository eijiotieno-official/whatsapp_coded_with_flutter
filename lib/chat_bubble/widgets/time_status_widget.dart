// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_bubble/models/message.dart';
import 'package:whatsapp_coded_with_flutter/chat_bubble/utils/format_time.dart';

// Define a StatelessWidget named 'TimeStatusWidget'
class TimeStatusWidget extends StatelessWidget {
  // Declare a final field to store the message information
  final Message message;

  // Constructor to initialize the TimeStatusWidget with a required 'message' parameter
  const TimeStatusWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Retrieve the status from the message
    Status status = message.status;

    // Build the widget with padding and a Wrap widget containing time and status indicators
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Wrap(
        children: [
          // Display the formatted time using the 'formatTime' function
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              formatTime(dateTime: message.time, context: context),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // Display an icon based on the message status (read, delivered, sent)
          Padding(
            padding: const EdgeInsets.only(left: 2.5, top: 5),
            child: Icon(
              // Use a conditional statement to determine the appropriate icon
              status == Status.read || status == Status.delivered
                  ? Icons
                      .done_all_rounded // Display double check for read/delivered
                  : status == Status.sent
                      ? Icons.done_rounded // Display a single check for sent
                      : Icons
                          .watch_later_outlined, // Display a clock icon for other statuses
              // Set the icon color based on the status (light blue for read, black45 for others)
              color: status == Status.read
                  ? Colors.lightBlueAccent
                  : Colors.black45,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
