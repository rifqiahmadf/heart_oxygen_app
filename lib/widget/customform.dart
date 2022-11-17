import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

class CustomForm extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final EdgeInsets margin;
  final bool isPassword;
  const CustomForm(
      {required this.textController,
      required this.hintText,
      required this.margin,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      margin: margin,
      child: TextFormField(
        obscureText: isPassword,
        controller: textController,
        enableSuggestions: false,
        autocorrect: false,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: cTextButtonBlack,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: const BorderSide(
              width: 2,
              color: cPurpleColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: const BorderSide(
              width: 3,
              color: cPurpleDarkColor,
            ),
          ),
        ),
      ),
    );
  }
}
