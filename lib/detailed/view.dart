import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subway_stations/detailed/model.dart' as model;
import 'package:subway_stations/util/styles.dart';

class DetailedStation extends StatelessWidget {
  final DocumentSnapshot baseStation;
  final int distance;

  DetailedStation(this.baseStation, this.distance);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Station details'),
        ),
        body: FutureBuilder(
          future: model.getDetailedStation(baseStation.documentID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DetailedStationWidget(
                  baseStation, snapshot.data, distance);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
}

class DetailedStationWidget extends StatelessWidget {
  final DocumentSnapshot baseStation;
  final DocumentSnapshot detailedStation;
  final int distance;

  DetailedStationWidget(this.baseStation, this.detailedStation, this.distance);

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController();
    _descriptionController.text = detailedStation['description'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: FadeInImage.assetNetwork(
                placeholder: 'images/placeholder_800x400.gif',
                image: detailedStation['imageUrl'],
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      baseStation['name'],
                      style: TextStyles.BIG_BOLD,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Latitude: ${baseStation['latitude']}',
                      style: TextStyles.MEDIUM_BOLD_ITALIC,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Longitude: ${baseStation['longitude']}',
                      style: TextStyles.MEDIUM_BOLD_ITALIC,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Distance to station: ${distance}m',
                      style: TextStyles.MEDIUM_BOLD,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            detailedStation['description'],
            style: TextStyles.MEDIUM_NORMAL,
          ),
        ),
      ],
    );
  }
}
