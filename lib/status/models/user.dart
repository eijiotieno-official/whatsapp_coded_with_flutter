// Import the StatusModel class from the specified file
import 'package:whatsapp_coded_with_flutter/status/models/status.dart';

// Define a class named UserModel to represent a user with associated information
class UserModel {
  // Declare final fields to store information about the user
  final String id; // User ID
  final String name; // User name
  final String photo; // URL of user's profile photo
  final List<StatusModel>
      status; // List of status updates associated with the user

  // Constructor to initialize the fields when creating a new instance of UserModel
  UserModel({
    required this.id, // Required parameter for user ID
    required this.name, // Required parameter for user name
    required this.photo, // Required parameter for URL of user's profile photo
    required this.status, // Required parameter for list of status updates
  });
}
