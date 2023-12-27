// Import necessary packages for Flutter
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_coded_with_flutter/status/models/status.dart';
import 'package:whatsapp_coded_with_flutter/status/models/user.dart';
import 'package:whatsapp_coded_with_flutter/status/widgets/arc_widget.dart';

// Define a StatelessWidget named LeadingWidget
class LeadingWidget extends StatelessWidget {
  // Declare a final field to store the user information
  final UserModel user;

  // Constructor to initialize the user field when creating a new instance of LeadingWidget
  const LeadingWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Set the radius for the circular avatar
    double radius = 25;
    // Retrieve the list of status updates associated with the user
    List<StatusModel> status = user.status;

    // Build a Stack widget to display the circular avatar and the status arc
    return Stack(
      alignment: Alignment.center,
      children: [
        // Draw the status arc using a CustomPaint widget
        SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: CustomPaint(
            painter: Arc(
              // Pass the number of arcs and already watched count to the Arc painter
              alreadyWatch: status
                  .where((element) => element.viewers.contains(user.id))
                  .length,
              numberOfArc: status.length,
            ),
          ),
        ),
        // Display the user's circular avatar using a CircleAvatar widget
        CircleAvatar(
          radius: radius - 3,
          // Set the background image of the circular avatar using CachedNetworkImageProvider
          backgroundImage: CachedNetworkImageProvider(user.photo),
        ),
      ],
    );
  }
}
