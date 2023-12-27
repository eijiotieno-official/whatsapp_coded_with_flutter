// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_bubble/models/message.dart';

// Import the custom MessageWidget to display individual messages
import 'message_widget.dart';

// Define a StatefulWidget named 'MessagesWidget'
class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key});

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

// Define the corresponding State class '_MessagesWidgetState'
class _MessagesWidgetState extends State<MessagesWidget> {
  // Declare a List to store a collection of Message objects
  List<Message> messages = [
    // Sample messages with different statuses
    Message(
      text:
          "All the content and graphics published in this e-book are the property of Tutorials Point Pvt. Ltd. The user of this e-book is prohibited to reuse, retain, copy, distribute or republish any contents or a part of contents of this e-book in any manner without written consent of the publisher.",
      time: DateTime.now(),
      status: Status.waiting,
    ),
    Message(
      text:
          "This type of learning algorithms are basically used in clustering problems.",
      time: DateTime.now(),
      status: Status.sent,
    ),
    Message(
      text: "Mathematics is considered",
      time: DateTime.now(),
      status: Status.delivered,
    ),
    Message(
      text: "Hey",
      time: DateTime.now(),
      status: Status.read,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Build a ListView of messages using the provided itemBuilder
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        // Retrieve each message from the list and pass it to the MessageWidget
        Message message = messages[index];
        return MessageWidget(message: message);
      },
    );
  }
}
