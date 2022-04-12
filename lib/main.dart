import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

// void main() async {
// WidgetsFlutterBinding.ensureInitialized();
// await Firebase.initializeApp();
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
