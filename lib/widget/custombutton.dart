import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color color;
  final EdgeInsets margin;
  final Function() onPressed;
  const CustomButton({
    this.height = 43,
    this.width = double.infinity,
    this.color = cPurpleColor,
    this.margin = const EdgeInsets.only(top: 14, bottom: 28),
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: (onPressed),
        child: Text(
          text,
          style: cTextButtonWhite,
        ),
      ),
    );
  }
}
