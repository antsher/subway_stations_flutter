class Station {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String imageUrl;

  Station({this.id, this.name, this.latitude, this.longitude, this.imageUrl});

  factory Station.fromJson(Map<String, dynamic> json) => Station(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      imageUrl: json['imageUrl']);
}

class StationList {
  final List<Station> stations;

  StationList({this.stations});

  factory StationList.fromJson(List<dynamic> parsedJson) => StationList(
      stations: parsedJson.map((i) => Station.fromJson(i)).toList());
}
