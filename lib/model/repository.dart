import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:subway_stations/model/entities.dart';

Future<List<Station>> fetchStations() async {
  final response = await http.get('https://my-json-server.typicode.com/'
      'antsher/subway_stations_api/stations');
  if (response.statusCode == 200) {
    final stations = StationList.fromJson(json.decode(response.body)).stations;
    for (final station in stations) {
      Firestore.instance
          .collection("base_info")
          .document(station.id.toString())
          .setData({
        'name': station.name,
        'latitude': station.latitude,
        'longitude': station.longitude,
        'imageUrl': station.imageUrl
      });
    }
    return stations;
  } else {
    throw Exception('Failed to load post');
  }
}
