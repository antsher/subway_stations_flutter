import 'package:flutter/material.dart';
import 'package:subway_stations/model/entities.dart';
import 'package:subway_stations/model/repository.dart' as model;
import 'package:subway_stations/view/styles.dart';

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
          body: FutureBuilder<StationList>(
            future: model.fetchStations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StationListWidget(stations: snapshot.data.stations);
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
  Widget build(BuildContext context) => ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) => Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
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
      );
}
