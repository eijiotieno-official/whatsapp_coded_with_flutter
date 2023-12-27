// Import necessary packages and files for Flutter
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';

// Define a StatelessWidget named StatusViewAppBar
class StatusViewAppBar extends StatelessWidget {
  // Declare a final field to store the user information
  final UserModel user;

  // Constructor to initialize the user field when creating a new instance of StatusViewAppBar
  const StatusViewAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Build a column containing the app bar, flexible container, reply widget, and viewers widget
    return Column(
      children: [
        // Build the app bar using the buildAppBar method
        buildAppBar(context: context),
        // Build a flexible container to fill remaining space
        Flexible(
          child: Container(),
        ),
        // Build the reply widget using the buildReplyWidget method
        buildReplyWidget(),
        // Build the viewers widget using the buildViewersWidget method
        buildViewersWidget(),
      ],
    );
  }

  // Method to build the app bar
  Widget buildAppBar({required BuildContext context}) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          // Add a back button to navigate back when pressed
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          // Display user information in the title section
          title: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.photo),
            ),
            title: Text(
              // Display the user's name or "My Status" (for the current user)
              "current_user_id" != user.id ? user.name : "My Status",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  // Method to build the reply widget
  Widget buildReplyWidget() => "current_user_id" != user.id
      ? GestureDetector(
          onTap: () {
            debugPrint("Reply to Status");
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display an arrow-up icon for replying to the status
              Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
              ),
              // Display the text "Reply" below the arrow-up icon
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Reply",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      : const SizedBox.shrink(); // Return an empty widget if the current user

  // Method to build the viewers widget
  Widget buildViewersWidget() => "current_user_id" == user.id
      ? GestureDetector(
          onTap: () {
            debugPrint("Viewers to Status");
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display an eye icon for viewing the status viewers
              Icon(
                Icons.remove_red_eye,
                color: Colors.white,
              ),
              // Display the number of viewers below the eye icon (update with the current status view count)
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        )
      : const SizedBox
          .shrink(); // Return an empty widget if not the current user
}
