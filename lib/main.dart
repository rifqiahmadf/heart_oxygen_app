import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heart_oxygen_alarm/cubit/bottompage/bottompage_cubit.dart';
import 'package:heart_oxygen_alarm/pages/homepage.dart';
import 'package:heart_oxygen_alarm/pages/loginpage.dart';
import 'package:heart_oxygen_alarm/pages/registerpage.dart';
import 'package:heart_oxygen_alarm/pages/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottompageCubit(),
        ),
      ],
      child: MaterialApp(
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
          '/': (context) => const SplashScreen(),
          LoginPage.nameRoute: (context) => LoginPage(),
          RegisterPage.nameRoute: (context) => RegisterPage(),
          HomePage.nameRoute: (context) => HomePage(),
        },
      ),
    );
  }
}
