// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:whatsapp_coded_with_flutter/status/models/status.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';

// Import the custom StatusViewAppBar widget
import 'package:whatsapp_coded_with_flutter/status/widgets/status_view_appbar.dart';

// Define a StatefulWidget named StatusViewPage
class StatusViewPage extends StatefulWidget {
  // Declare a final field to store the user information
  final UserModel user;

  // Constructor to initialize the user field when creating a new instance of StatusViewPage
  const StatusViewPage({super.key, required this.user});

  @override
  State<StatusViewPage> createState() => _StatusViewPageState();
}

// Define the state class for StatusViewPage
class _StatusViewPageState extends State<StatusViewPage> {
  // Create a StoryController to control the story view
  final StoryController _storyController = StoryController();

  // Initialize an empty list of StoryItem to store the user's status updates
  List<StoryItem> status = [];

  // Method to process and convert status updates into StoryItem
  void processStatus() {
    // Iterate through each status update in the user's status list
    for (var element in widget.user.status) {
      // Check the type of status (image or video) and add the corresponding StoryItem
      if (element.type == StatusType.image) {
        setState(() {
          status.add(StoryItem.pageImage(
              url: element.url, controller: _storyController));
        });
      } else {
        setState(() {
          status.add(
              StoryItem.pageVideo(element.url, controller: _storyController));
        });
      }
    }
  }

  // Override the initState method to call processStatus when the widget is initialized
  @override
  void initState() {
    processStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the status list is empty and display a CircularProgressIndicator if true
    return status.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        // Otherwise, build the main scaffold with a Stack containing StoryView and StatusViewAppBar
        : Scaffold(
            body: Stack(
              children: [
                // Positioned.fill is used to fill the available space with the StoryView widget
                Positioned.fill(
                  child: StoryView(
                    // Provide the list of StoryItems to the StoryView
                    storyItems: status,
                    controller: _storyController,
                    // Callback when a story is shown to update the viewers list
                    onStoryShow: (o) {
                      // Update the viewers list with the current user
                      // This is a placeholder comment, you may implement this functionality
                    },
                    // Callback when the entire story is completed to navigate back
                    onComplete: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                // Display the custom StatusViewAppBar widget above the StoryView
                StatusViewAppBar(user: widget.user),
              ],
            ),
          );
  }
}
