import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/Custom_Widget/text_bar.dart';
import 'package:project/sign_up.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var key = GlobalKey<FormState>();
  var show = true;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                      'Hello Again!',
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
                      'Wellcome back you\'ve been missed!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    TextBar(
                      label: 'Email',
                      focusNode: focusNode,
                      hintText: 'Enter Email ID',
                      prefixIcon: Icons.mail_outline,
                      controller: email,
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    TextBar(
                      label: 'Password',
                      focusNode: focusNode2,
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
                          color: focusNode2.hasFocus ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ButtonBar(
                      buttonPadding: EdgeInsets.zero,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(primary: Colors.grey),
                          child: Text(
                            'Recovery Password',
                            style: GoogleFonts.roboto(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          print('Valid');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.maxFinite, size.width * 0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: Colors.redAccent),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.black,
                          ),
                        ),
                        Text('Or Continue With'),
                        Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/Icons/google.png',
                            width: size.width / 12,
                            height: size.width / 12,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: size.width * 0.035, horizontal: size.width * 0.06),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.white, width: 2))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/Icons/apple.png',
                            width: size.width / 12,
                            height: size.width / 12,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: size.width * 0.035, horizontal: size.width * 0.06),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.white, width: 2))),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/Icons/facebook.png',
                            width: size.width / 12,
                            height: size.width / 12,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: size.width * 0.035, horizontal: size.width * 0.06),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: Colors.white, width: 2))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Not a member? ',
                        style: GoogleFonts.notoSerif(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Register now',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
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
}
