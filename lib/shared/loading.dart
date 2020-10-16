import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// show loading screen
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.green,
          size: 80.0,
        ),
      ),
    );
  }
}
