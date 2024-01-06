// Importing the necessary Flutter material and custom widget
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/widgets/chat_input_widget.dart';

// Creating a StatefulWidget named ChatPage
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  // Creating the state for ChatPage
  @override
  State<ChatPage> createState() => _ChatPageState();
}

// Creating the state class _ChatPageState for ChatPage
class _ChatPageState extends State<ChatPage> {
  // Overriding the build method of StatefulWidget
  @override
  Widget build(BuildContext context) {
    // Scaffold widget for the overall page structure
    return Scaffold(
      // AppBar at the top of the page with a title
      appBar: AppBar(
        title: const Text("WhatsApp Coded With Flutter"),
      ),
      // Body of the page containing a Column with a ChatInputWidget
      body: const Column(
        // Aligning the column's children at the bottom
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Including the ChatInputWidget in the column
          ChatInputWidget(),
        ],
      ),
    );
  }
}
