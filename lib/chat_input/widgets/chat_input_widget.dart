// Importing the necessary Flutter material and custom widgets
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/widgets/back_widget.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/widgets/emoji_picker_widget.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/widgets/front_widget.dart';
import 'package:whatsapp_coded_with_flutter/chat_input/widgets/send_button_widget.dart';

// Creating a StatefulWidget named ChatInputWidget
class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({Key? key}) : super(key: key);

  // Creating the state for ChatInputWidget
  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

// Creating the state class _ChatInputWidgetState for ChatInputWidget
class _ChatInputWidgetState extends State<ChatInputWidget> {
  // Creating TextEditingController for text input and ScrollController for scrolling
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _emojiOpen = false;
  void toggleEmojis() {
    setState(() {
      _emojiOpen = !_emojiOpen;
    });
  }

  void addEmojiToTextController({required Emoji emoji}) {
    _textEditingController.text = _textEditingController.text + emoji.emoji;
    _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textEditingController.text.length));
    setState(() {});
  }

  // Overriding the build method of StatefulWidget
  @override
  Widget build(BuildContext context) {
    // Padding widget for spacing around the chat input area
    return Padding(
      padding: const EdgeInsets.only(
        left: 6,
        bottom: 6,
        right: 6,
      ),
      // Stack widget to layer components on top of each other
      child: Column(
        children: [
          if (_emojiOpen)
            EmojiPickerWidget(
                addEmojiToTextController: addEmojiToTextController),
          Stack(
            children: [
              // Main row containing the chat input card and a transparent send button
              Row(
                children: [
                  // Expanded Card containing the chat input components
                  Expanded(
                    child: Card(
                      // Setting card color to the background color from the theme
                      color: Theme.of(context).colorScheme.background,
                      margin: const EdgeInsets.only(right: 6),
                      // Setting card shape with rounded corners
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Stack(
                        children: [
                          // BackWidget for the back side of the chat input
                          BackWidget(
                            textEditingController: _textEditingController,
                            toggleEmojis: toggleEmojis,
                          ),
                          // FrontWidget for the front side of the chat input
                          FrontWidget(
                            textEditingController: _textEditingController,
                            scrollController: _scrollController,
                            // Callback when the text in the text field changes
                            onChanged: () {
                              // Triggering a rebuild when the text changes
                              setState(() {});
                            },
                            toggleEmojis: toggleEmojis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // IconButton with a transparent send icon
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.send, color: Colors.transparent),
                  ),
                ],
              ),
              // Positioned row aligning the SendButtonWidget at the bottom right
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      // Spacer to push the SendButtonWidget to the right
                      const Spacer(),
                      // SendButtonWidget for sending messages
                      SendButtonWidget(controller: _textEditingController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
