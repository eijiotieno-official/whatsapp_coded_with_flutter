// Importing the necessary Flutter material and Fluttertoast packages
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Creating a custom widget named BackWidget that extends StatelessWidget
class BackWidget extends StatelessWidget {
  // Declaring a final variable 'textEditingController' of type TextEditingController
  final TextEditingController textEditingController;
  final Function toggleEmojis;

  // Constructor to receive the TextEditingController
  const BackWidget(
      {Key? key, required this.textEditingController, required this.toggleEmojis})
      : super(key: key);

  // Overriding the build method of StatelessWidget
  @override
  Widget build(BuildContext context) {
    // Positioned widget to fill the entire screen and align the content at the bottom center
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            // Emoji button
            IconButton(
              onPressed: () {
                toggleEmojis();
              },
              icon: const Icon(Icons.emoji_emotions_outlined),
            ),
            // Expanded TextField with transparent text color and no border
            const Expanded(
              child: TextField(
                maxLines: null,
                // Setting text color to transparent
                style: TextStyle(
                  color: Colors.transparent,
                ),
                decoration: InputDecoration(
                  hintText: "",
                  // Setting hint text color to transparent
                  hintStyle: TextStyle(
                    color: Colors.transparent,
                  ),
                  // Removing the border from the input decoration
                  border: InputBorder.none,
                ),
              ),
            ),
            // Attachment button
            IconButton(
              onPressed: () {
                // Show a toast message when the attachment button is pressed
                Fluttertoast.showToast(msg: "show picker");
              },
              icon: const Icon(Icons.attach_file_outlined),
            ),
            // Camera button only visible when text input is empty
            if (textEditingController.text.isEmpty)
              IconButton(
                onPressed: () {
                  // Show a toast message when the camera button is pressed
                  Fluttertoast.showToast(msg: "open camera");
                },
                icon: const Icon(Icons.camera_alt_outlined),
              ),
          ],
        ),
      ),
    );
  }
}
