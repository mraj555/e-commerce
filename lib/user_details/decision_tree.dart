import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/user_details/log_in.dart';
import 'package:project/user_details/verify_email_page.dart';
import 'package:project/Internet_Connection/connectivity_provider.dart';
import 'package:project/Internet_Connection/no_internet.dart';
import 'package:provider/provider.dart';

class DecisionTree extends StatefulWidget {
  const DecisionTree({Key? key}) : super(key: key);

  @override
  State<DecisionTree> createState() => _DecisionTreeState();
}

class _DecisionTreeState extends State<DecisionTree> {

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<ConnectivityProvider>(
          builder: (context, model, child) {
            if(model.isOnline != null) {
              return model.isOnline ? StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return const VerifyEmailPage();
                  }
                  else {
                    return const LogIn();
                  }
                },
              ) : NoInternet();
            }
            return Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
