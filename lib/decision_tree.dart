import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/log_in.dart';
import 'package:project/verify_email_page.dart';

class DecisionTree extends StatelessWidget {
  const DecisionTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            print('Data : ${snapshot.data}');
            if(snapshot.hasData) {
             return VerifyEmailPage();
            }
            else {
              return LogIn();
            }
          },
        ),
      ),
    );
  }
}
