import 'package:firebase_database/firebase_database.dart';
//import 'package:flutter/cupertino.dart';
import 'package:sesigo/model/sesigo_user.dart';

class RealtimeService {
  DatabaseReference _metshelo =
      FirebaseDatabase.instance.reference().child('metshelo');

  SesigoUser sesigoUser;
  final String uid = '';

  // get metshelo
  Stream<DataSnapshot> get metsheloGroups {
    return _metshelo.once().asStream().map((event) => null);
  }

  // get user data
  DatabaseReference _dijoRef =
      FirebaseDatabase.instance.reference().child('dijo');

  //_dijoRef.child(uid);
  Stream<Event> get userDijoData {
    //dbRef.orderByChild('n').equalTo('Anna').once(),
    return _dijoRef.child('01').orderByChild('n').equalTo('Anna').onValue;
  }
}
