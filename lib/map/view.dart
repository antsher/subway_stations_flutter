import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subway_stations/common/base_stations_model.dart' as model;
import 'package:subway_stations/util/haversine.dart' as haversine;
import 'package:tuple/tuple.dart';

class StationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: model.getStationsAndPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StationMapWidget(stationsAndPosition: snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      );
}

class StationMapWidget extends StatefulWidget {
  final Tuple2<QuerySnapshot, Position> stationsAndPosition;

  StationMapWidget({@required this.stationsAndPosition});

  @override
  State<StatefulWidget> createState() =>
      StationMapWidgetState(stationsAndPosition: stationsAndPosition);
}

class StationMapWidgetState extends State<StationMapWidget> {
  final Tuple2<QuerySnapshot, Position> stationsAndPosition;
  GoogleMapController mapController;

  StationMapWidgetState({@required this.stationsAndPosition});

  @override
  Widget build(BuildContext context) => GoogleMap(
        onMapCreated: _onMapCreated,
      );

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      controller.moveCamera(
          CameraUpdate.newLatLngZoom(LatLng(53.9086154, 27.5735358), 10.5));
      _showMarkers(_createMarkers());
    });
  }

  void _showMarkers(Iterable<MarkerOptions> markers) =>
      markers.forEach((marker) => mapController.addMarker(marker));

  Iterable<MarkerOptions> _createMarkers() =>
      stationsAndPosition.item1.documents
          .map((station) => _createMarker(station));

  MarkerOptions _createMarker(DocumentSnapshot station) {
    final distance = haversine.distance(
        station['latitude'],
        station['longitude'],
        stationsAndPosition.item2.latitude,
        stationsAndPosition.item2.longitude);
    return MarkerOptions(
        position: LatLng(station['latitude'], station['longitude']),
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText:
            InfoWindowText(station['name'], "${distance.round()}m"));
  }
}
