import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_oxygen_alarm/cubit/map/map_cubit.dart';

class HomeSolusi extends StatelessWidget {
  const HomeSolusi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Halaman Solusi'),
        ],
      ),
    );
  }
}
