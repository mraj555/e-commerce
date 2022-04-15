import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/home_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isVerified) {
      sendVerification();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }

  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(
      () {
        isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      },
    );
    if (isVerified) timer?.cancel();
  }

  sendVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification().whenComplete(
            () => print('Email Sent Successfully.'),
          );
    } catch (e) {
      print('Error : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size.width * 0.1);
    return SafeArea(
      child: Scaffold(
        body: isVerified
            ? HomePage()
            : Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'A verification email has been sent to your email.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: size.width * 0.04),
                        ),
                        SizedBox(height: size.width * 0.05),
                        ElevatedButton.icon(
                          onPressed: () {

                          },
                          label: Text('Verify Email'),
                          icon: Icon(Icons.mail_outline),
                        ),
                        SizedBox(height: size.width * 0.01),
                        OutlinedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            GoogleSignIn().signOut();
                            FacebookAuth.instance.logOut();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
