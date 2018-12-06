class Station {
  final String name;
  final double latitude;
  final double longitude;

  Station({this.name, this.latitude, this.longitude});

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
}

class StationList {
  final List<Station> stations;

  StationList({this.stations});

  factory StationList.fromJson(List<dynamic> parsedJson) {
    List<Station> stations =
        parsedJson.map((i) => Station.fromJson(i)).toList();
    return StationList(stations: stations);
  }
}
