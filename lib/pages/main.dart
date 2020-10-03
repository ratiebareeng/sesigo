import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sesigo/pages/home.dart';
import 'package:sesigo/pages/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  /*FirebaseAuth.instance.onAuthStateChanged.listen((User user) {
  if (user == null) {
  print('User is currently signed out!');
  } else {
  print('User is signed in!');
  }
  });

}
*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.rubikTextTheme(), // set app font
      ),
      debugShowCheckedModeBanner: false, // hide debug sticker
      home: _getLandingPage(),
    );
  }
}

Widget _getLandingPage() {
  return StreamBuilder<FirebaseUser>(
    stream: FirebaseAuth.instance.onAuthStateChanged,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        print("user logged in" + snapshot.data.phoneNumber);
        if (snapshot.data.providerData.length == 1) {
          return snapshot.data.phoneNumber.isNotEmpty ? Home(
            firebaseUser: snapshot.data,) : PhoneAuth();
        } else {
          return Home(firebaseUser: snapshot.data,);
        }
      } else {
        print("user logged out");
        return PhoneAuth();
      }
    },
  );
}

