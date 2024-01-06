// Importing the necessary Flutter material package
import 'package:flutter/material.dart';

// Creating a custom widget named SendButtonWidget that extends StatelessWidget
class SendButtonWidget extends StatelessWidget {
  // Declaring a final variable 'controller' of type TextEditingController
  final TextEditingController controller;

  // Constructor to receive the TextEditingController
  const SendButtonWidget({Key? key, required this.controller})
      : super(key: key);

  // Overriding the build method of StatelessWidget
  @override
  Widget build(BuildContext context) {
    // GestureDetector for handling long press and tap events
    return GestureDetector(
      // Callback when long press starts
      onLongPressStart: (details) {
        // Implementation for handling long press start
      },
      // Callback when long press ends
      onLongPressEnd: (details) {
        // Implementation for handling long press end
      },
      // Callback when tap occurs
      onTap: () {
        // Implementation for handling tap
      },
      // Container with circular shape and background color
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Setting the background color using the primary color with opacity
          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ),
        // IconButton with a mic or send icon based on text input
        child: IconButton(
          // Disabled onPressed for now
          onPressed: null,
          // Icon dynamically changes based on text input
          icon: Icon(
            controller.text.trim().isEmpty
                ? Icons.mic // Mic icon when text is empty
                : Icons.send, // Send icon when there is text
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
