import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sesigo/model/sesigo_user.dart';
import 'package:sesigo/screens/auth/authenticate_user.dart';
import 'package:sesigo/screens/home/home.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get user from provider
    final sesigoUser = Provider.of<SesigoUser>(context);
    print(sesigoUser);
    if (sesigoUser == null) {
      return AuthenticateUser();
    } else {
      return Home();
    }
  }
}
