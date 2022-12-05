/*import 'package:flutter_blue/flutter_blue.dart';

class BluetoothServices {
  static var scanSubscription;
  static FlutterBlue flutterBlueInstance = FlutterBlue.instance;
  static var device;

  static initBluetooth() {
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
        //Alert user to turn on bluetooth.
      } else if (state == BluetoothState.on) {
        //if bluetooth is enabled then go ahead.
        //Make sure user's device gps is on.
        scanForDevices();
      }
    });
  }

  static void scanForDevices() async {
    scanSubscription = flutterBlueInstance.scan().listen((scanResult) async {
      if (scanResult.device.name == "your_device_name") {
        print("found device");
//Assigning bluetooth device
        device = scanResult.device;
//After that we stop the scanning for device
        stopScanning();
      }
    });
  }

  static void stopScanning() {
    flutterBlueInstance.stopScan();
    scanSubscription.cancel();
  }
}
*/