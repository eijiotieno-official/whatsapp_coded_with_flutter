// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/status/models/status.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';
import 'package:whatsapp_coded_with_flutter/status/pages/status_view_page.dart';
import 'package:whatsapp_coded_with_flutter/status/utils/format_time.dart';

// Import the custom LeadingWidget
import 'leading_widget.dart';

// Define a StatelessWidget named UserWidget
class UserWidget extends StatelessWidget {
  // Declare a final field to store the user information
  final UserModel user;

  // Constructor to initialize the user field when creating a new instance of UserWidget
  const UserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Retrieve the latest status update associated with the user
    StatusModel status = user.status.last;

    // Build a ListTile widget for displaying user information
    return ListTile(
      // Define onTap callback to navigate to the StatusViewPage when the user is tapped
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // Navigate to the StatusViewPage and pass the user information
              return StatusViewPage(user: user);
            },
          ),
        );
      },
      // Display the user's circular avatar using the custom LeadingWidget
      leading: LeadingWidget(user: user),
      // Display the user's name or "My Status" if it's the current user
      title: Text(user.id == "current_user_id" ? "My Status" : user.name),
      // Display the formatted time of the latest status update
      subtitle: Text(formatTime(dateTime: status.time, context: context)),
      // Display the more options icon for the current user, otherwise null
      trailing:
          user.id == "current_user_id" ? const Icon(Icons.more_vert) : null,
    );
  }
}
