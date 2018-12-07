class Station {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String imageUrl;

  Station(this.id, this.name, this.latitude, this.longitude, this.imageUrl);

  factory Station.fromJson(Map<String, dynamic> json) => Station(
      json['id'],
      json['name'],
      json['latitude'].toDouble(),
      json['longitude'].toDouble(),
      json['imageUrl']);
}

class StationList {
  final List<Station> stations;

  StationList({this.stations});

  factory StationList.fromJson(List<dynamic> parsedJson) => StationList(
      stations: parsedJson.map((i) => Station.fromJson(i)).toList());
}
