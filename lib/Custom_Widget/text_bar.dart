import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBar extends StatefulWidget {
  final FocusNode focusNode;
  final String hintText;
  final IconData prefixIcon;
  bool? obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  TextBar({required this.focusNode, required this.hintText, required this.prefixIcon, this.obscureText, required this.controller, this.suffixIcon, this.keyboardType, required this.validator});

  @override
  State<TextBar> createState() => _TextBarState();
}

class _TextBarState extends State<TextBar> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: (val) {
        setState(
          () {
            val = widget.controller.text;
          },
        );
      },
      obscuringCharacter: '*',
      obscureText: widget.obscureText == null ? false : widget.obscureText!,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: InputBorder.none,
          hintText: widget.hintText,
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
            widget.prefixIcon,
            color: widget.focusNode.hasFocus ? Colors.green : Colors.grey,
          ),
          suffixIcon: widget.suffixIcon,
          contentPadding: EdgeInsets.only(top: size.width * 0.055, bottom: size.width * 0.055)),
    );
  }
}
