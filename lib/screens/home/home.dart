import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesigo/model/sesigo_user.dart';
import 'package:sesigo/screens/home/user_details.dart';
import 'package:sesigo/services/auth_service.dart';
import 'package:sesigo/services/firestore_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbRef = FirebaseDatabase.instance.reference().child('dijo').child('01');
  // create instance of auth service
  final AuthService _authService = AuthService();
  List<Map<dynamic, dynamic>> months = [];

  // List<Map<dynamic, dynamic>> months = [];

  @override
  Widget build(BuildContext context) {
    // access data from stream through provider

    final userDetails = Provider.of<SesigoUser>(context);
    SesigoUser sesigoUser = SesigoUser(
        uid: userDetails.uid,
        name: userDetails.name,
        email: userDetails.email,
        img: userDetails.img);

    return StreamProvider<SesigoUser>.value(
      value: FirestoreService(sesigoUser: sesigoUser).users,
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          title: Text(
            "Sesigo",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserDetails()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    fit: BoxFit.cover,
                    imageUrl: userDetails.img,
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () async {
                await _authService.signOut();
                /* var result = await FirestoreService(sesigoUser: sesigoUser)
                    .addDijoMembers();
                print(result); */
              },
              child: Text('sign out'),
            ),
          ],
        ),
        body: FutureBuilder(
            future: dbRef.orderByChild('n').equalTo('Anna').once(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                months.clear();
                Map<dynamic, dynamic> monthData = snapshot.data.value;
                monthData.forEach((key, value) {
                  months.add(value);
                });

                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: months.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        /* child: DataTable(
                          columns: [
                            DataColumn(label: Text("month"), numeric: false),
                            DataColumn(label: Text("paid"), numeric: false),
                            DataColumn(label: Text("balance"), numeric: false),
                            DataColumn(label: Text("interest"), numeric: false),
                            //DataColumn(label: Text("month"), numeric: false),
                            //DataColumn(label: Text("month"), numeric: false),
                          ],
                          rows: months.map((e) => DataRow(
                            selected: months.contains(element),
                            cells: null)),
                        ), */

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Month: ' +
                                      months[index]["m"].toString()),
                                  Text('Balance: ' +
                                      months[index]["b"].toString()),
                                  Text(
                                      'Paid: ' + months[index]["c"].toString()),
                                  Text('Loan Balance: ' +
                                      months[index]["lb"].toString()),
                                  Text('Interest Raised: ' +
                                      months[index]["i"].toString()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
