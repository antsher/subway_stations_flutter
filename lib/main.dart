import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:subway_stations/home/view.dart';
import 'package:subway_stations/list/view.dart';
import 'package:subway_stations/map/view.dart';

void main() => runApp(SubwayStationsApp());

class SubwayStationsApp extends StatelessWidget {
  @override
  build(BuildContext context) =>
      MaterialApp(title: 'Subway Stations', home: ContentWidget());
}

class ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  final List<Widget> _children = [Home(), StationMap(), StationList()];
  int _currentIndex = 0;

  @override
  initState() {
    super.initState();
    checkPermissions();
  }

  void checkPermissions() async {
    final permissionGranted =
        await SimplePermissions.checkPermission(Permission.AccessFineLocation);
    if (!permissionGranted) {
      requestPermissions();
    }
  }

  void requestPermissions() async {
    final permissionStatus = await SimplePermissions.requestPermission(
        Permission.AccessFineLocation);
    if (permissionStatus == PermissionStatus.deniedNeverAsk) {
      SimplePermissions.openSettings();
    } else if (permissionStatus != PermissionStatus.authorized) {
      requestPermissions();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Subway stations'),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('List'),
            ),
          ],
        ),
      );

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
