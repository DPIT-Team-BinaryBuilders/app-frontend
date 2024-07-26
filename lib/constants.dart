import 'package:flutter/material.dart';

double getScreenWidth() {
  // Get the screen width without BuildContext
  final window = WidgetsBinding.instance.window;
  final size = window.physicalSize / window.devicePixelRatio;
  return size.width;
}
