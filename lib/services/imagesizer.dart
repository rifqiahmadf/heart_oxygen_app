//! Google Maps 4 : import dart ui dan services, dan tinggal ikutin aja kodingan method dibawah
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ImageSizer{
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}