import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';
import 'package:subway_stations/util/streams.dart' as streams;

const String BASE_INFO_COLLECTION = 'base_info';

Stream<Tuple2<QuerySnapshot, Position>> getStationsAndPosition() =>
    streams.zipTwo(
        Firestore.instance.collection(BASE_INFO_COLLECTION).snapshots(),
        Geolocator().getCurrentPosition().asStream());