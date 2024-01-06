import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/pages/chat_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const ChatPage(),
    );
  }
}

