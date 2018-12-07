import 'package:flutter/material.dart';
import 'package:subway_stations/model/entities.dart';
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
          body: FutureBuilder<List<Station>>(
            future: model.fetchStations(),
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
  final List<Station> stations;

  StationListWidget({@required this.stations}) : super();

  @override
  build(BuildContext context) => ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) => _buildRow(index),
      );

  _buildRow(int index) => Row(
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
                    stations[index].name,
                    style: TextStyles.BIG,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 4, 0, 4),
                  child: Text(
                    stations[index].latitude.toString(),
                    style: TextStyles.NORMAL_ITALIC,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12, 4, 0, 8),
                  child: Text(
                    stations[index].longitude.toString(),
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
              image: stations[index].imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
}
