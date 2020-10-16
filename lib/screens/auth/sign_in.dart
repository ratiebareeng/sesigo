import 'package:flutter/material.dart';
import 'package:sesigo/services/auth_service.dart';
import 'package:sesigo/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // get instance of auth service class to access anon sign in method
  final AuthService _authService = AuthService();
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              title: Text(
                "Sign in",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.green,
                  child: Text("Continue with Google"),
                  onPressed: () async {
                    // show loading screen
                    setState(() {
                      loading = true;
                    });
                    // call anon sign in and await for a result
                    dynamic authResult = await _authService.signInWithGoogle();
                    // handle result cases
                    if (authResult == null) {
                      setState(() {
                        error = 'error signing in';
                        loading = false;
                      });
                      print("error sigining in");
                    } // no need to handle else; stream handles state change routes
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
            //),
          );
  }
}
