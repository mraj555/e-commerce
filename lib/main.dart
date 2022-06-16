import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/welcome_pages/splash_screen.dart';
import 'package:project/Internet_Connection/connectivity_provider.dart';
import 'package:provider/provider.dart';

import 'user_details/decision_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: const DecisionTree(),
        ),
      ],
      child: MaterialApp(
        routes: {
          '/signupdecision': (context) => const DecisionTree(),
        },
        debugShowCheckedModeBanner: false,
        home: const DecisionTree(),
      ),
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
