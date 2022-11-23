import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heart_oxygen_alarm/model/markermodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  getLocationApi(String uri) async {
    List<MarkerModel> markerModel = [];
    Uri url = Uri.parse(uri);
    try {
      var hasilRespon = await http.get(url);

      if (json.decode(hasilRespon.body) != null) {
        var dataRespon = json.decode(hasilRespon.body) as Map<String, dynamic>;

        var result = dataRespon['results'] as List;

        result.forEach((element) {
          markerModel.add(
            MarkerModel(
              id: element['place_id'],
              name: element['name'],
              latitude: element['geometry']['location']['lat'],
              longitude: element['geometry']['location']['lng'],
              alamat: element['vicinity'],
            ),
          );
        });

        emit(MapSuccess(markerModel));
      }
    } catch (e) {
      rethrow;
    }
  }
}
