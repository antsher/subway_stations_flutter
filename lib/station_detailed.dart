import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subway_stations/model/repository.dart' as model;
import 'package:subway_stations/util/styles.dart';

class DetailedStation extends StatelessWidget {
  final DocumentSnapshot document;
  final double distance;

  DetailedStation(this.document, this.distance);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Station details'),
        ),
        body: Column(
          children: [
            Card(
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
            ),
            FutureBuilder(
              future: model.getDetailedStation(document.documentID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DetailedStationWidget(snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      );
}

class DetailedStationWidget extends StatelessWidget {
  final DocumentSnapshot detailedStation;

  DetailedStationWidget(this.detailedStation);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'images/loading.gif',
      image: detailedStation['imageUrl'],
      fit: BoxFit.contain,
    );
  }
}
