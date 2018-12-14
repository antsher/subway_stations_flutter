import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:subway_stations/util/streams.dart' as streams;
import 'package:tuple/tuple.dart';

const String BASE_INFO_COLLECTION = 'base_info';
const String ADVANCED_INFO_COLLECTION = 'advanced_info';

Stream<Tuple2<QuerySnapshot, Position>> getStationsAndPosition() =>
    streams.zipTwo(
        Firestore.instance.collection(BASE_INFO_COLLECTION).snapshots(),
        Geolocator().getCurrentPosition().asStream());

Future<DocumentSnapshot> getDetailedStation(String id) =>
    Firestore.instance.collection(ADVANCED_INFO_COLLECTION).document(id).get();
