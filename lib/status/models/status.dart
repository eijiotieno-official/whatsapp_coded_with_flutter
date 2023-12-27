// Define an enumeration named StatusType with two possible values: image and video
enum StatusType { image, video }

// Define a class named StatusModel to represent a status update
class StatusModel {
  // Declare final fields to store information about the status update
  final String userId; // User ID associated with the status
  final String url; // URL of the status content (image or video)
  final StatusType type; // Type of status content (image or video)
  final List<String> viewers; // List of user IDs who viewed the status
  final DateTime time; // Time when the status was created

  // Constructor to initialize the fields when creating a new instance of StatusModel
  StatusModel({
    required this.userId, // Required parameter for user ID
    required this.url, // Required parameter for URL
    required this.type, // Required parameter for status type
    required this.viewers, // Required parameter for list of viewers
    required this.time, // Required parameter for timestamp
  });
}
