import 'package:flutter/material.dart';

ValueNotifier<int> imageInt = ValueNotifier<int>(0);
ValueNotifier<int> tabPageIndex = ValueNotifier<int>(0);
ValueNotifier<bool> imageUrlSet = ValueNotifier(false);
ValueNotifier<String> language = ValueNotifier('English');
Size screenSize = WidgetsBinding.instance.window.physicalSize;
double width = screenSize.width;
double height = screenSize.height;
double widths = screenSize.width / 100;
double heights = screenSize.height / 100;

TextStyle normalTexts = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal, // Underline for clickable look
  color: Color(0xFF1B1919), // Optional: change color on tap
);
TextStyle boldTexts = const TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold, // Underline for clickable look
  color: Color(0xFF1B1919), // Optional: change color on tap
);
