// Import necessary packages and files for Flutter
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';

// Import the custom UserWidget
import 'user_widget.dart';

// Define a StatelessWidget named RecentStatusListWidget
class RecentStatusListWidget extends StatelessWidget {
  // Declare a final field to store a list of user information
  final List<UserModel> users;

  // Constructor to initialize the users field when creating a new instance of RecentStatusListWidget
  const RecentStatusListWidget({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    // Build a SliverList using the builder pattern to create dynamic list items
    return SliverList.builder(
      // Set the item count to the length of the users list
      itemCount: users.length,
      // Define the itemBuilder callback to create each user widget in the list
      itemBuilder: (context, index) {
        // Retrieve the user information for the current index
        UserModel user = users[index];
        // Return a UserWidget with the current user information
        return UserWidget(user: user);
      },
    );
  }
}
