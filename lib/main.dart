import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (BuildContext context) =>
//           MaterialApp(
//           useInheritedMediaQuery: true,
//           debugShowCheckedModeBanner: false,
//           home: SplashScreen(),
//     ),
//   ),);
// }
