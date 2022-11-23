import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heart_oxygen_alarm/cubit/map/map_cubit.dart';
import 'package:heart_oxygen_alarm/services/geolocatorpermission.dart';
import 'package:heart_oxygen_alarm/services/imagesizer.dart';
import 'package:heart_oxygen_alarm/shared/theme.dart';

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

    var markerIcon = BitmapDescriptor.fromBytes(
      // const ImageConfiguration(),
      await ImageSizer.getBytesFromAsset(
        'assets/images/custommarkersmall2.png',
        200,
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
    if (mounted) {
      setState(() {});
    }
  }

  _addMarkerRumahSakit(
      String id, LatLng location, String title, String snippet) async {
    //? kalau dari assets langsung tanpa ImageSizer gunakan fromassetsImages
    /*var markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/images/custommarkersmall2.png',
    );*/

    var markerIcon = BitmapDescriptor.fromBytes(
      // const ImageConfiguration(),
      await ImageSizer.getBytesFromAsset(
        'assets/images/custommarkerrumahsakit.png',
        200,
      ),
    );
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
      icon: markerIcon,
    );

    _markers[id] = marker;
    if (mounted) {
      setState(() {});
    }
  }

  //! GeoLocator 3 : bikin method getCurrentLocation yang mengambil posisi ketika sudah mendapatkan permission
  Future<void> _getCurrentLocation() async {
    Position position = await GeoLocatorPermission.determinePosition();

    // print('latitude : ${position.latitude},longitude : ${position.longitude},');
    if (mounted) {
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
    _getCurrentLocation().then((_) {
      context.read<MapCubit>().getLocationApi(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=rumah%20sakit&location=${_position!.latitude},${_position!.longitude}&radius=1500&type=rumah%20sakit&key=AIzaSyCyw7pp0GDBgTfaf3cSGf9XqA3PQG4Fl_4');
    });
  }

  @override
  Widget build(BuildContext context) {
    //! Google Maps 3 : langsung panggil widget google maps, masukkan variabel yang diatas tadi, dan sampai sini sudah cukup untuk menampilkan google maps secara sederhana
    return _position == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              BlocBuilder<MapCubit, MapState>(
                builder: (context, state) {
                  if (state is MapSuccess) {
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 14,
                      ),
                      onMapCreated: (controller) {
                        _mapController = controller;
                        //! Google Maps 6 : tambahkan method addMaker ke dalam onMapCreated
                        _addMarker(
                          'id1',
                          currentLocation,
                        );
                        for (var element in state.marker) {
                          _addMarkerRumahSakit(
                            element.id,
                            LatLng(
                              element.latitude,
                              element.longitude,
                            ),
                            element.name,
                            element.alamat,
                          );
                        }
                      },
                      //! Google Maps 5 : masukkan variabel set _markers ke parameter markers
                      markers: _markers.values.toSet(),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SafeArea(
                child: BlocBuilder<MapCubit, MapState>(
                  builder: (context, state) {
                    if (state is MapSuccess) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: SizedBox(
                          height: 110,
                          child: ListView.builder(
                            shrinkWrap: true,
                            clipBehavior: Clip.none,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.marker.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: InkWell(
                                  onTap: () {
                                    _mapController.animateCamera(
                                      CameraUpdate.newLatLng(
                                        LatLng(
                                          state.marker[index].latitude,
                                          state.marker[index].longitude,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 250,
                                    height: 100,
                                    margin: const EdgeInsets.only(
                                      right: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 4,
                                        color: cPurpleDarkColor,
                                      ),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'assets/images/rumahsakitbackground.jpeg',
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 80,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.marker[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: cTextPurpleMaps,
                                                ),
                                                Text(
                                                  state.marker[index].alamat,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
              ),
            ],
          );
  }
}
