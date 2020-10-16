import 'package:flutter/material.dart';
import 'package:sesigo/model/member.dart';
import 'package:sesigo/services/firestore_service.dart';
import 'package:sesigo/shared/constants.dart';

class AddUserRecord extends StatefulWidget {
  final Member member;
  AddUserRecord({Key key, @required this.member});
  @override
  _AddUserRecordState createState() => _AddUserRecordState();
}

class _AddUserRecordState extends State<AddUserRecord> {
  Member memberToUpdate;
  String month = "";
  String userName = "";
  double lb = 0.0;
  double ib = 0.0;
  double tb = 0.0;
  double contribution = 0.0;
  double loanPayment = 0.0;
  String error = "";

// used to identify form
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  //_AddUserRecordState(this.memberToUpdate);

  @override
  Widget build(BuildContext context) {
    memberToUpdate = widget.member;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          widget.member.name,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 48.0),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: widget.member.name,
                        readOnly: true,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Member Name', labelText: 'Account Name'),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Month is required' : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'November', labelText: 'Month'),
                        onChanged: (val) {
                          setState(() {
                            month = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        //initialValue: widget.member.loanBal.toString(),
                        // readOnly: true,
                        validator: (val) =>
                            val.isEmpty ? 'Loan Balance is required' : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Loan Balance',
                            labelText: 'Loan Balance'),
                        onChanged: (val) {
                          setState(() {
                            lb = double.parse(val);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        //initialValue: widget.member.interestDue.toString(),
                        // readOnly: true,
                        validator: (val) =>
                            val.isEmpty ? 'Interest Due is required' : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Interest Due',
                            labelText: 'Interest Due'),
                        onChanged: (val) {
                          setState(() {
                            ib = double.parse(val);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        //initialValue: widget.member.totalBal.toString(),
                        //readOnly: true,
                        validator: (val) =>
                            val.isEmpty ? 'Total Balance is required' : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Total Balance',
                            labelText: 'Total Balance'),
                        onChanged: (val) {
                          setState(() {
                            tb = double.parse(val);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        //initialValue: '0.0',
                        validator: (val) => val.isEmpty
                            ? 'Monthly contribution is required'
                            : null,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Contribution',
                            labelText: 'Contribution'),
                        onChanged: (val) {
                          setState(() {
                            contribution = double.parse(val);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        initialValue: '0.0',
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Loan Payment',
                            labelText: 'Loan Payment'),
                        onChanged: (val) {
                          setState(() {
                            loanPayment = double.parse(val);
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'save',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //print('success');
                            dynamic result =
                                await _firestoreService.addUserRecord(
                                    widget.member.id,
                                    month,
                                    lb,
                                    ib,
                                    tb,
                                    contribution,
                                    loanPayment);
                            if (result == 'already exists') {
                              setState(() {
                                error = 'already exists';
                              });
                            } else if (result == null) {
                              setState(() {
                                error = 'something went wrong';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
