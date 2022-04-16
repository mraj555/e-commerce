import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:project/main_screen.dart';

import 'drawer_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body: ZoomDrawer(
        mainScreen: MainScreen(),
        menuScreen: DrawerScreen(),
        menuBackgroundColor: Colors.black,
        showShadow: true,
        borderRadius: 20,
        angle: 0.0,
        shadowLayer1Color: Colors.transparent,
      ),
    ),);
  }
}
