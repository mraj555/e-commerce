import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/user_details/log_in.dart';
import 'package:project/tab_page.dart';
import 'package:project/user_details/verification_page.dart';

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
    if (FirebaseAuth.instance.currentUser != null) {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    }

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
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(
        () {
          isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        },
      );
      if (isVerified) timer?.cancel();
    }
  }

  sendVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification().whenComplete(
              () {
                if (kDebugMode) {
                  print('Email Sent Successfully.');
                }
              },
            );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context)?.settings.name);
    return SafeArea(
      child: Scaffold(
        body: isVerified && ModalRoute.of(context)?.settings.name == '/signupdecision' ? const LogIn() :
            isVerified ? const HomePage()
            : const VerificationPage()
      ),
    );
  }
}
