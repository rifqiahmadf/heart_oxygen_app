import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//! Google Maps 1 : ubah ke stateful
class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  //! Google Maps 2 : bikin variabel initial position, mapController, dan marker
  LatLng currentLocation = const LatLng(-6.202448, 106.769376);
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 18,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
