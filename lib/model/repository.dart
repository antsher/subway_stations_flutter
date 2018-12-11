import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tuple/tuple.dart';

const String BASE_INFO_COLLECTION = "base_info";

Stream<Tuple2<QuerySnapshot, Position>> getStationsAndPosition() {
  return StreamZip([
    Firestore.instance.collection(BASE_INFO_COLLECTION).snapshots(),
    Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
        .asStream()
  ]).map((sp) => Tuple2<QuerySnapshot, Position>(sp[0], sp[1]));
}
