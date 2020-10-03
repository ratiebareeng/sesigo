import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sesigo/pages/numeric_pad.dart';

import 'home.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;
  String smsCode = "";

  VerifyPhone({this.phoneNumber});

  Future<bool> signupUser(String phone, BuildContext context) async {
    //if(phone.contains("267", 0))
    phone = "+267" + phone;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          //Navigator.pop(context);

          AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);

          FirebaseUser user = authResult.user;
          if(user != null) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Home(firebaseUser: user,)
            ));
          } else {
            print("Error authenticating user is null");
          }
        }, // called only when verification is done
        verificationFailed: (AuthException exception) {
          if (exception.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          } else {
            print(exception.message);
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          if(smsCode.isNotEmpty && smsCode.length == 4) {
            AuthCredential authCredential = PhoneAuthProvider.getCredential(
                verificationId: verificationId,
                smsCode: smsCode);

            AuthResult authResult = await _firebaseAuth.signInWithCredential(authCredential);
            FirebaseUser firebaseUser = authResult.user;

            if(firebaseUser != null) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Home(firebaseUser: firebaseUser,)
              ));
            } else {
              print("Error authenticating user is null");
            }
          }
          /*showCupertinoDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter verification code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _codeController,
                      )
                    ],
                  ),actions: [
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.black,
                    color: Colors.green[700],
                    onPressed: () async {
                      AuthCredential authCredential = PhoneAuthProvider.getCredential(
                          verificationId: verificationId,
                          smsCode: smsCode);

                      AuthResult authResult = await _firebaseAuth.signInWithCredential(authCredential);
                      FirebaseUser firebaseUser = authResult.user;

                      if(firebaseUser != null) {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Home(firebaseUser: firebaseUser,)
                        ));
                      } else {
                        print("Error authenticating user is null");
                      }
                    },
                  )
                ],
                );
              }
          );*/
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          //auto retrieve sms timed out
        }
    );
  }

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String smsCode = "";


  @override
  void initState() {
    widget.signupUser(widget.phoneNumber, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Verify phone number",
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
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                      child: Text(
                        "SMS code has been sent to " + widget.phoneNumber,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildCodeRow(smsCode.length > 0 ? smsCode.substring(0, 1) : ""),
                          buildCodeRow(smsCode.length > 1 ? smsCode.substring(1, 2) : ""),
                          buildCodeRow(smsCode.length > 2 ? smsCode.substring(2, 3) : ""),
                          buildCodeRow(smsCode.length > 3 ? smsCode.substring(3, 4) : ""),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Haven't receive code?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(width: 8.0,),

                          GestureDetector(
                            onTap: () {
                              print("resend code");
                            },
                            child: Text(
                              "Resend sms",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.smsCode = smsCode;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Verify code",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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
                  if(numberValue != -1) {
                    if(smsCode.length < 4) {
                      smsCode = smsCode + numberValue.toString();
                    }
                  } else {
                    smsCode = smsCode.substring(0, smsCode.length - 1);
                  }
                });
                //print(numberValue);
                print(smsCode);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCodeRow(String codeDigit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(16),),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0,
                spreadRadius: 1,
                offset: Offset(0.0, 0.25),
              )
            ],
          ),
          child: Center(
            child: Text(
              codeDigit,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }
}
