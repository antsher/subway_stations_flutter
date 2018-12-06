import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:subway_stations/model/entities.dart';

Future<StationList> fetchStations() async {
  final response = await http
      .get('https://my-json-server.typicode.com/BeeWhy/metro/stations');
  if (response.statusCode == 200) {
    return StationList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}
