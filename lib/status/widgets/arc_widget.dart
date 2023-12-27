// Import necessary packages for Flutter
import 'dart:math';
import 'package:flutter/material.dart';

// Define a custom painter class named Arc
class Arc extends CustomPainter {
  // Declare final fields to store the number of arcs and already watched count
  final int numberOfArc;
  final int alreadyWatch;

  // Constructor to initialize the fields when creating a new instance of Arc
  Arc({
    required this.numberOfArc, // Required parameter for the number of arcs
    required this.alreadyWatch, // Required parameter for the already watched count
  });

  // Utility function to convert degrees to radians
  double doubleToAngle(double angle) => angle * pi / 180.0;

  // Function to draw arcs with specified parameters
  void drawArcWithRadius(
    Canvas canvas,
    Offset center,
    double radius,
    double angle,
    Paint seenPaint,
    Paint unSeenPaint,
    double start,
    double spacing,
    int number,
    int alreadyWatch,
  ) {
    for (var i = 0; i < number; i++) {
      // Draw arcs using the drawArc method on the canvas
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          doubleToAngle((start + ((angle + spacing) * i))),
          doubleToAngle(angle),
          false,
          alreadyWatch - 1 >= i
              ? seenPaint
              : unSeenPaint); // Use seenPaint for watched arcs, unSeenPaint otherwise
    }
  }

  // Override the paint method to define how to paint the custom arc
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the center of the canvas
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    // Calculate the radius of the arc
    final double radius = size.width / 2.0;
    // Calculate the angle based on the number of arcs
    double angle = numberOfArc == 1 ? 360.0 : (360.0 / numberOfArc - 15);
    // Starting angle for drawing arcs
    var startingAngle = 270.0;

    // Define Paint objects for seen and unseen arcs
    Paint seenPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.black.withOpacity(0.5);

    Paint unSeenPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = Colors.lightGreen;

    // Draw arcs with specified parameters
    drawArcWithRadius(canvas, center, radius, angle, seenPaint, unSeenPaint,
        startingAngle, 15, numberOfArc, alreadyWatch);
  }

  // Override the shouldRepaint method to control whether the painter should repaint
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Always repaint for simplicity in this example
  }
}
