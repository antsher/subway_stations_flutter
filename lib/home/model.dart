import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subway_stations/home/entities.dart';

const String MESSAGE_COLLECTION = 'messages';

Future<String> sendMessage(Message message) async => await Firestore.instance
    .collection(MESSAGE_COLLECTION)
    .add({'name': message.name, 'text': message.text})
    .then((value) => Future.value('Success ${value.toString()}'))
    .catchError((error) => Future.value(error.toString()));
