import 'package:flutter/material.dart';
import 'package:sesigo/screens/auth/sign_in.dart';

class AuthenticateUser extends StatefulWidget {
  @override
  _AuthenticateUserState createState() => _AuthenticateUserState();
}

class _AuthenticateUserState extends State<AuthenticateUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
