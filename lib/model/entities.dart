class Station {
  final String name;
  final double latitude;
  final double longitude;

  Station({this.name, this.latitude, this.longitude});

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json['name'],
        latitude: json['latitude'].toDouble(),
        longitude: json['longitude'].toDouble(),
      );
}

class StationList {
  final List<Station> stations;

  StationList({this.stations});

  factory StationList.fromJson(List<dynamic> parsedJson) => StationList(
      stations: parsedJson.map((i) => Station.fromJson(i)).toList());
}
