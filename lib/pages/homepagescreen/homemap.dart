import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heart_oxygen_alarm/services/geolocatorpermission.dart';
import 'package:heart_oxygen_alarm/services/imagesizer.dart';

//! Google Maps 1 : ubah ke stateful
class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  //! GeoLocator 1 : bikin variabel Position
  Position? _position;
  //! Google Maps 2 : bikin variabel initial position, mapController, dan marker
  LatLng currentLocation = const LatLng(-6.202448, 106.769376);
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  //! Google Maps 5 : bikin method addMarker
  _addMarker(String id, LatLng location) async {
    //? kalau dari assets langsung tanpa ImageSizer gunakan fromassetsImages
    /*var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/custommarkersmall2.png',
    );*/

    var markerIcon = await BitmapDescriptor.fromBytes(
      // const ImageConfiguration(),
      await ImageSizer.getBytesFromAsset(
        'assets/images/custommarkersmall2.png',
        300,
      ),
    );
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'Lokasi Saat ini',
        snippet: 'Aplikasi HeartRate & Oxygen',
      ),
      icon: markerIcon,
    );

    _markers[id] = marker;
    if(mounted){
setState(() {});
    }
    
  }

  //! GeoLocator 3 : bikin method getCurrentLocation yang mengambil posisi ketika sudah mendapatkan permission
  void _getCurrentLocation() async {
    Position position = await GeoLocatorPermission.determinePosition();

    // print('latitude : ${position.latitude},longitude : ${position.longitude},');
    if(mounted){
      setState(() {
      _position = position;
      currentLocation = LatLng(position.latitude, position.longitude);
    });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //! GeoLocator 4 : panggil method getLocation di initState
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    //! Google Maps 3 : langsung panggil widget google maps, masukkan variabel yang diatas tadi, dan sampai sini sudah cukup untuk menampilkan google maps secara sederhana
    return _position == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 18,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              //! Google Maps 6 : tambahkan method addMaker ke dalam onMapCreated
              _addMarker(
                'id1',
                currentLocation,
              );
            },
            //! Google Maps 5 : masukkan variabel set _markers ke parameter markers
            markers: _markers.values.toSet(),
          );
  }
}
