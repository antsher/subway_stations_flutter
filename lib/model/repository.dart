import 'package:cloud_firestore/cloud_firestore.dart';

const String BASE_INFO_COLLECTION = "base_info";

Stream<QuerySnapshot> fetchStations() =>
    Firestore.instance.collection(BASE_INFO_COLLECTION).snapshots();
