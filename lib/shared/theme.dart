import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultRadius = 10;

const Color cWhiteColor = Color(0xffFFFFFF);
const Color cGreyColor = Color(0xff747775);
const Color cPurpleColor = Color(0xff9287FF);
const Color cBlackColor = Color(0xff545151);
const Color cBlackTextFieldColor = Color(0xff3F3D56);
const Color cPurpleDarkColor = Color(0xff5C40CC);
const Color cRedColor = Color(0xffD7443E);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
FontWeight extraBold = FontWeight.w800;
FontWeight black = FontWeight.w900;

TextStyle cHeader1Style = GoogleFonts.poppins(
  color: cGreyColor,
  fontSize: 20,
  fontWeight: semiBold,
);

TextStyle cTextButtonBlack = GoogleFonts.poppins(
  color: cBlackColor,
  fontSize: 12,
  fontWeight: light,
);

TextStyle cTextButtonWhite = GoogleFonts.poppins(
  color: cWhiteColor,
  fontSize: 15,
  fontWeight: bold,
);

TextStyle cNavBarText = GoogleFonts.poppins(
  color: Color(0xffA4A2A8),
  fontSize: 18,
  fontWeight: bold,
);
