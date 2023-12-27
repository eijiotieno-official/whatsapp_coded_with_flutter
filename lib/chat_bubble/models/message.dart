// Define an enumeration named 'Status' to represent the status of a message
enum Status { waiting, sent, delivered, read }

// Define a class named 'Message' to represent a message with text, time, and status
class Message {
  // Declare final fields to store the text content of the message, the time it was sent, and its status
  final String text;
  final DateTime time;
  final Status status;

  // Constructor to initialize the Message object with required parameters
  Message({
    required this.text,
    required this.time,
    required this.status,
  });
}
