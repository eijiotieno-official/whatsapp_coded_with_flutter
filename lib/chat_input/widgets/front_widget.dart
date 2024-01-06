// Importing the necessary Flutter material and Fluttertoast packages
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Creating a custom widget named FrontWidget that extends StatelessWidget
class FrontWidget extends StatelessWidget {
  // Declaring final variables to receive necessary parameters
  final TextEditingController textEditingController;
  final ScrollController scrollController;
  final Function onChanged;
  final Function toggleEmojis;

  // Constructor to receive necessary parameters
  const FrontWidget({
    Key? key,
    required this.textEditingController,
    required this.scrollController,
    required this.onChanged,
    required this.toggleEmojis,
  }) : super(key: key);

  // Overriding the build method of StatelessWidget
  @override
  Widget build(BuildContext context) {
    // Row widget containing three main elements: emoji button, text input, and attachment button
    return Row(
      children: [
        // Emoji button
        IconButton(
          onPressed: () {
            toggleEmojis();
          },
          icon: const Icon(
            Icons.emoji_emotions_outlined,
            color: Colors.transparent,
          ),
        ),
        // Expanded TextField wrapped in a Scrollbar
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            radius: const Radius.circular(5),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 0.5,
              ),
              child: TextField(
                // Setting the controller for the text field
                controller: textEditingController,
                // Setting the minimum and maximum lines for the text field
                minLines: 1,
                maxLines: 6,
                onTap: () {
                  // Callback when the text field is tapped
                  toggleEmojis();
                },
                decoration: const InputDecoration(
                  // Setting content padding, border, and hintText for the input decoration
                  contentPadding: EdgeInsets.only(),
                  border: InputBorder.none,
                  hintText: "Message",
                ),
                // Callback when the text in the text field changes
                onChanged: (value) => onChanged(),
              ),
            ),
          ),
        ),
        // Attachment button
        IconButton(
          onPressed: () {
            // Show a toast message when the attachment button is pressed
            Fluttertoast.showToast(msg: "show picker");
          },
          icon:
              const Icon(Icons.attach_file_outlined, color: Colors.transparent),
        ),
      ],
    );
  }
}
