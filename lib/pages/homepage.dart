import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heart_oxygen_alarm/cubit/bottompage/bottompage_cubit.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homemap.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homesolusi.dart';
import 'package:heart_oxygen_alarm/pages/homepagescreen/homeutama.dart';
import 'package:heart_oxygen_alarm/pages/loginpage.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const nameRoute = '/homePage';

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<BottompageCubit>();
    Widget contentPage(int index) {
      switch (index) {
        case 1:
          return HomeMap();
        case 2:
          return HomeUtama();
        case 3:
          return HomeSolusi();
        default:
          return HomeUtama();
      }
    }

    TextStyle navBarColor(int index, int state) {
      if (index == state) {
        return cNavBarText.copyWith(
          color: cPurpleDarkColor,
        );
      }
      return cNavBarText;
    }

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/headerhome.png'),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  print('masuk');
                  Navigator.pushNamed(
                    context,
                    LoginPage.nameRoute,
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: cPurpleColor,
                ),
              ),
            ),
          ),
          //
          //
          BlocBuilder<BottompageCubit, int>(
            builder: (context, state) {
              return contentPage(state);
            },
          ),

          //
          //
          //! bottom nav bar
          BlocBuilder<BottompageCubit, int>(
            builder: (context, state) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      height: 105,
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      width: double.infinity,
                      color: state == 1
                          ? Color(0xffF4F3FF).withOpacity(0.2)
                          : Color(0xffF4F3FF),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              bloc.setPage(1);
                            },
                            child: Text(
                              'Map',
                              style: navBarColor(1, state),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bloc.setPage(2);
                            },
                            child: Text(
                              'Utama',
                              style: navBarColor(2, state),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              bloc.setPage(3);
                            },
                            child: Text(
                              'Solusi',
                              style: navBarColor(3, state),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
