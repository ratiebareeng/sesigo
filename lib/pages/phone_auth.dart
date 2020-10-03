import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sesigo/pages/home.dart';
import 'package:sesigo/pages/numeric_pad.dart';
import 'package:sesigo/pages/verify_phone.dart';

class PhoneAuth extends StatefulWidget {

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  String phoneNumber = "";
  String accountStatus = '******';
  FirebaseUser currentUser;
  FirebaseAuth _auth;

/*  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _getCurrentUser();
    print('here outside async');
  }

  _getCurrentUser() async {
    currentUser = await _auth.currentUser();
    print('Hello ' + currentUser.phoneNumber.toString());
    if (currentUser != null) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => Home(firebaseUser: currentUser,)
      ));
    } else {
      print("Error authenticating user is null");
    }
  }*/

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      leading: Icon(
        Icons.close,
        size: 30,
        color: Colors.black,
      ),
      title: Text(
        "Phone sign up",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      textTheme: Theme
          .of(context)
          .textTheme,
    ),
    body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 0.9],
                    colors: [
                      Colors.white,
                      Colors.grey[100]
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 64),
                      child: Text(
                        "You will receive a 4-digit verification code shortly.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[600]
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.13,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(25)
                  )
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [

                    Container(
                      width: 230,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Enter your phone number",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),

                          SizedBox(width: 8,),

                          Text(
                            phoneNumber,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                VerifyPhone(phoneNumber: phoneNumber,)),
                          );
                          // signupUser(phoneNumber, context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[400],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            NumericPad(
                onNumberSelected: (numberValue) {
                  setState(() {
                    if (numberValue != -1) {
                      phoneNumber = phoneNumber + numberValue.toString();
                    } else {
                      phoneNumber =
                          phoneNumber.substring(0, phoneNumber.length - 1);
                    }
                  });
                }
            ),

          ],
        )
    ),
  );
}


}
