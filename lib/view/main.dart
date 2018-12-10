import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subway_stations/model/repository.dart' as model;
import 'package:subway_stations/view/styles.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(BuildContext context) => MaterialApp(
        title: 'Subway Stations',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('List Mode'),
          ),
          body: StreamBuilder(
            stream: model.fetchStations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StationListWidget(stations: snapshot.data);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );
}

class StationListWidget extends StatelessWidget {
  final QuerySnapshot stations;

  StationListWidget({@required this.stations}) : super();

  @override
  build(BuildContext context) => ListView.builder(
        itemCount: stations.documents.length,
        itemBuilder: (context, index) =>
            _buildListItem(context, stations.documents[index]),
      );

  _buildListItem(BuildContext context, DocumentSnapshot document) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    document['name'],
                    style: TextStyles.BIG,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 4, 0, 4),
                  child: Text(
                    document['latitude'].toString(),
                    style: TextStyles.NORMAL_ITALIC,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 4, 0, 8),
                  child: Text(
                    document['longitude'].toString(),
                    style: TextStyles.NORMAL_ITALIC,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 164,
            height: 94,
            padding: EdgeInsets.all(12),
            alignment: Alignment.centerRight,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: document['imageUrl'],
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
}
