import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';
import 'package:heart_oxygen_alarm/pages/loginpage.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    Timer(Duration(seconds: 1), () {
      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, LoginPage.nameRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.nameRoute, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cPurpleColor,
      body: SafeArea(
        child: TweenAnimationBuilder(
          curve: Curves.easeInOutExpo,
          duration: const Duration(milliseconds: 300),
          tween: Tween(begin: 0.9, end: 1.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logounikom.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                  ),
                  child: Text(
                    "APLIKASI MONITORING KADAR OKSIGEN DARAH BERBASIS ANDROID MAMANFAATKAN TEKNOLOGI SMARTBAND",
                    style: cNavBarText.copyWith(color: cWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                  ),
                  child: Text(
                    "Fakhri Yusrizal Hidayat",
                    style: cTextButtonWhite.copyWith(color: cWhiteColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          builder: (BuildContext context, dynamic value, Widget? child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
