import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

//! Bluetooth : 4 ketika bluetooth OFF, maka akan memanggil layar ini
class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            //! Bluetooth : 4.1 kalau state tidak null, tampilkan state.toString (off), kalau bluetooth null atau tidak tersedia tampilkan not Available
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle2
                  ?.copyWith(color: Colors.white),
            ),
            //! Bluetooth : 4.2 tombol untuk menyalakan bluetooth kalau bluetooth off
            ElevatedButton(
              onPressed: Platform.isAndroid
                  ? () => FlutterBluePlus.instance.turnOn()
                  : null,
              child: const Text('TURN ON'),
            ),
          ],
        ),
      ),
    );
  }
}