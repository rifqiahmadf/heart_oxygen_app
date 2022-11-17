import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';
import 'package:heart_oxygen_alarm/pages/loginpage.dart';
import 'package:heart_oxygen_alarm/pages/registerpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        /* brightness: Brightness.dark,
          primaryColorDark: Colors.amber,
          primaryColor: Colors.cyan,
          primarySwatch: Colors.green,*/

        //colorScheme: ColorScheme.dark(primary: Colors.cyan),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routes: {
        '/': (context) => LoginPage(),
        LoginPage.nameRoute: (context) => LoginPage(),
        RegisterPage.nameRoute: (context) => RegisterPage(),
        HomePage.nameRoute: (context) => HomePage(),
      },
    );
  }
}
