import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/User%20Details/log_in.dart';
import 'package:project/User%20Details/verify_email_page.dart';

class DecisionTree extends StatelessWidget {
  const DecisionTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
             return const VerifyEmailPage();
            }
            else {
              return const LogIn();
            }
          },
        ),
      ),
    );
  }
}
