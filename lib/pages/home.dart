import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final FirebaseUser firebaseUser;

  Home({this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Logged in successfully",
              style: TextStyle(
                color: Colors.lightGreen[500],
                fontSize: 32,
              ),
            ),
            SizedBox(height: 16,),
            Text(
              "${firebaseUser.displayName}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16,),
            Text(
              "${firebaseUser.phoneNumber}",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
