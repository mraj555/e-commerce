import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Custom_Widget/text_bar.dart';
import 'package:project/user_details/decision_tree.dart';
import 'package:project/user_details/log_in.dart';
import 'package:project/user_details/verification_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var key = GlobalKey<FormState>();
  var show = true;
  var c_show = true;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.07, right: size.width * 0.07, top: size.width * 0.1, bottom: size.width * 0.07),
              child: Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.06,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      'Here\'s your first step with us!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    TextBar(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Name is Required.';
                        }
                      },
                      focusNode: focusNode,
                      keyboardType: TextInputType.name,
                      hintText: 'Enter Your Name',
                      prefixIcon: Icons.account_circle_outlined,
                      controller: name,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextBar(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Email is Required';
                        }
                        if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z.-]+\.[a-z]+").hasMatch(val)) {
                          return 'Enter a Valid Email.';
                        }
                      },
                      focusNode: focusNode2,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Enter Email ID',
                      prefixIcon: Icons.mail_outline,
                      controller: email,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextBar(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Mobile Number is Required';
                        }
                        if (val.length < 10) {
                          return 'Enter a Valid Mobile Number.';
                        }
                      },
                      keyboardType: TextInputType.phone,
                      focusNode: focusNode3,
                      hintText: 'Enter Mobile No.',
                      prefixIcon: Icons.phone,
                      controller: mobile,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextBar(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Password is Required';
                        }
                        if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) {
                          return 'Enter a Valid Password.';
                        }
                      },
                      focusNode: focusNode4,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Enter Password',
                      prefixIcon: Icons.password,
                      controller: password,
                      obscureText: show,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                                () {
                              show = !show;
                            },
                          );
                        },
                        child: Icon(
                          show == true ? Icons.visibility : Icons.visibility_off,
                          color: focusNode4.hasFocus ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextBar(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Confirm Password is Required';
                        }
                        if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) {
                          return 'Enter a Valid Confirm Password.';
                        }
                        if (confirm_password.text != password.text) {
                          return 'Confirm Password Do not match.';
                        }
                      },
                      focusNode: focusNode5,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Enter Confirm Password',
                      prefixIcon: Icons.password,
                      controller: confirm_password,
                      obscureText: c_show,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(
                                () {
                              c_show = !c_show;
                            },
                          );
                        },
                        child: Icon(
                          c_show == true ? Icons.visibility : Icons.visibility_off,
                          color: focusNode5.hasFocus ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          signUpwithEmail();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.maxFinite, size.width * 0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.redAccent),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Already a Member? ',
                        style: GoogleFonts.notoSerif(color: Colors.black, fontSize: size.width * 0.035),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LogIn(),
                                    ),
                                  ),
                            style: GoogleFonts.lora(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  signUpwithEmail() async {
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      User? user = result.user;
      if (user != null) {
        await user.updateDisplayName(name.text);
        await user.reload();
      }
      await user!.sendEmailVerification().whenComplete(
            () => print('Email Send'),
          );
      DocumentReference documentReference = FirebaseFirestore.instance.collection('Users').doc(email.text);
      Map<String, dynamic> users = {'Name': name.text, 'Email': email.text, 'Mobile': mobile.text, 'Password': password.text, 'UID': user.uid, 'Provider': 'Email'};
      documentReference.set(users);

      Navigator.of(context).pushNamed('/signupdecision');
    } catch (e) {
      print(e);
    }
  }
}
