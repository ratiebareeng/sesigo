import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesigo/model/sesigo_user.dart';
import 'package:sesigo/screens/auth_wrapper.dart';
import 'package:sesigo/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // wrap entire app with stream provider so it can listen to auth state change
    return StreamProvider<SesigoUser>.value(
      value: AuthService().firebaseUser, // stream to listen to
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        home: AuthWrapper(),
      ),
    );
  }
}
