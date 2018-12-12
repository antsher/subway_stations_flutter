import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subway_stations/model/repository.dart' as model;
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
  build(BuildContext context) => ListView.builder(
        itemCount: stationsAndPosition.item1.documents.length,
        itemBuilder: (context, index) =>
            _buildListItem(context, stationsAndPosition.item1.documents[index]),
      );

  _buildListItem(BuildContext context, DocumentSnapshot document) {
    final distance = haversine.distance(
        document['latitude'],
        document['longitude'],
        stationsAndPosition.item2.latitude,
        stationsAndPosition.item2.longitude);
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  document['name'],
                  style: TextStyles.BIG,
                ),
                Text(
                  'Distance from your location: ${distance.round()}m',
                  style: TextStyles.NORMAL,
                ),
                Text(
                  'Latitude: ${document['latitude']}',
                  style: TextStyles.NORMAL_ITALIC,
                ),
                Text(
                  'Longitude: ${document['longitude']}',
                  style: TextStyles.NORMAL_ITALIC,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.centerRight,
              child: FadeInImage.assetNetwork(
                placeholder: 'images/loading.gif',
                image: document['imageUrl'],
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
