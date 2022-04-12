import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBar extends StatelessWidget {
  final String label;
  final FocusNode focusNode;
  final String hintText;
  final IconData prefixIcon;
  bool? obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  TextBar({
    required this.label,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText,
    required this.controller,
    this.suffixIcon,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      validator: (val) {
        if (val!.isEmpty) {
          return '$label is required.';
        }
        if (label == 'Password') {
          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) {
            return 'Enter a Valid Password.';
          }
        }
        if (label == 'Email') {
          if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z.-]+.[a-z]').hasMatch(val)) {
            return 'Enter a Valid Email.';
          }
        }
        if (label == 'Confirm Password') {
          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(val)) {
            return 'Enter a Valid Password.';
          }
        }
      },
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      obscuringCharacter: '*',
      obscureText: obscureText == null ? false : obscureText!,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: focusNode.hasFocus ? Colors.green : Colors.grey,
          ),
          suffixIcon: suffixIcon,
          contentPadding: EdgeInsets.only(top: size.width * 0.055, bottom: size.width * 0.055)),
    );
  }
}
