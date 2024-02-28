import 'package:flutter/material.dart';

class ResponsiveSize {
  // Method to calculate responsive width
  static double width(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width;
  }

  // Method to calculate responsive height
  static double height(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height;
  }

  // Method to calculate responsive text size
  static double textSize(BuildContext context, double size) {
    return MediaQuery.of(context).size.width * size;
  }
}
