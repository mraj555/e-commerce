import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/User%20Details/decision_tree.dart';
import 'package:project/product_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      routes: {
        '/signupdecision' : (context) => DecisionTree(),
      },
      debugShowCheckedModeBanner: false,
      home: const DecisionTree(),
    ),
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (BuildContext context) =>
//           MaterialApp(
//             routes: {
//               '/signupdecision': (context) => const DecisionTree(),
//             },
//             useInheritedMediaQuery: true,
//             debugShowCheckedModeBanner: false,
//             home: const DecisionTree(),
//           ),
//     ),);
// }
