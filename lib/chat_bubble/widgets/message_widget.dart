// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_bubble/models/message.dart';
import 'package:whatsapp_coded_with_flutter/chat_bubble/widgets/time_status_widget.dart';

// Define a StatelessWidget named 'MessageWidget'
class MessageWidget extends StatelessWidget {
  // Declare a final field to store the message information
  final Message message;

  // Constructor to initialize the MessageWidget with a required 'message' parameter
  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Build the widget with padding, a Column, and a Card containing the message content and time/status widget
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Use a Card to contain the message content and apply margin
          Card(
            margin: const EdgeInsets.all(2),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  children: [
                    // Display the message text with a specified font size
                    Text(
                      message.text,
                      style: const TextStyle(fontSize: 16),
                    ),
                    // Include the TimeStatusWidget to display time and status indicators
                    TimeStatusWidget(message: message),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
