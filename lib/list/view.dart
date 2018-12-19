import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subway_stations/common/base_stations_model.dart' as model;
import 'package:subway_stations/detailed/view.dart';
import 'package:subway_stations/util/haversine.dart' as haversine;
import 'package:subway_stations/util/styles.dart';
import 'package:tuple/tuple.dart';

class StationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: model.getStationsAndPosition(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StationListWidget(stationsAndPosition: snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      );
}

class StationListWidget extends StatelessWidget {
  final Tuple2<QuerySnapshot, Position> stationsAndPosition;

  StationListWidget({@required this.stationsAndPosition});

  @override
  build(BuildContext context) => ListView(children: _createItems(context));

  List<Widget> _createItems(BuildContext context) {
    List<Tuple2<Widget, double>> stationsWithDistances = stationsAndPosition
        .item1.documents
        .map((station) => _createItem(context, station))
        .toList();
    stationsWithDistances.sort((a, b) => a.item2.compareTo(b.item2));
    return stationsWithDistances
        .map((stationsWithDistance) => stationsWithDistance.item1)
        .toList();
  }

  Tuple2<Widget, double> _createItem(
      BuildContext context, DocumentSnapshot document) {
    final distance = haversine.distance(
        document['latitude'],
        document['longitude'],
        stationsAndPosition.item2.latitude,
        stationsAndPosition.item2.longitude);
    return Tuple2<Widget, double>(
        GestureDetector(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailedStation(document, distance.round()),
                ),
              ),
          child: Card(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      Text(
                        document['name'],
                        style: TextStyles.BIG_BOLD,
                      ),
                      Text(
                        'Distance from your location: ${distance.round()}m',
                        style: TextStyles.MEDIUM_NORMAL,
                      ),
                      Text(
                        'Latitude: ${document['latitude']}',
                        style: TextStyles.MEDIUM_NORMAL_ITALIC,
                      ),
                      Text(
                        'Longitude: ${document['longitude']}',
                        style: TextStyles.MEDIUM_NORMAL_ITALIC,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'images/loading.gif',
                        image: document['imageUrl'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        distance);
  }
}
