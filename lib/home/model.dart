import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:subway_stations/home/entities.dart';

const String MESSAGE_COLLECTION = 'messages';

final _auth = FirebaseAuth.instance;
final _googleSignIn = GoogleSignIn();

Future<String> sendMessage(Message message) async => await Firestore.instance
    .collection(MESSAGE_COLLECTION)
    .add({'name': message.name, 'text': message.text})
    .then((value) => Future.value('Success ${value.toString()}'))
    .catchError((error) => Future.value(error.toString()));

Future<FirebaseUser> signInWithGoogle() async {
  final googleSignInAccount = await _googleSignIn.signIn();
  final googleSignInAuthentication = await googleSignInAccount.authentication;
  return await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
}

Future<FirebaseUser> signInWithEmailAndPassword(
        String email, String password) async =>
    await _auth.signInWithEmailAndPassword(email: email, password: password);

Future<FirebaseUser> signUpWithEmailAndPassword(
        String email, String password) async =>
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
