import 'package:cloud_firestore/cloud_firestore.dart';

const String ADVANCED_INFO_COLLECTION = 'advanced_info';

Future<DocumentSnapshot> getDetailedStation(String id) =>
    Firestore.instance.collection(ADVANCED_INFO_COLLECTION).document(id).get();
