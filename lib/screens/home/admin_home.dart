import 'package:flutter/material.dart';
import 'package:sesigo/model/member.dart';
import 'package:sesigo/screens/home/motshelo_members.dart';
import 'package:sesigo/services/firestore_service.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Member>>.value(
      value: FirestoreService().dijoMembers,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            'Admin Home',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person_add_alt_1),
              onPressed: () async {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddDijo()),
                ); */
              },
              label: Text(''),
            ),
          ],
        ),
        body: MemberList(),
      ),
    );
  }
}
