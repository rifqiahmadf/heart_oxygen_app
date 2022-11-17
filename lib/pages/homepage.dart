import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homeutama.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const nameRoute = '/homePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/headerhome.png'),
          //
          //
          HomeUtama(),
          //
          //
          //! bottom nav bar
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 105,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              width: double.infinity,
              color: Color(0xffF4F3FF),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Map',
                      style: cNavBarText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Utama',
                      style: cNavBarText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Solusi',
                      style: cNavBarText.copyWith(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
