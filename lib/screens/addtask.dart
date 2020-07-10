import 'package:Personal_Wallet/pages/homepage.dart';
import 'package:Personal_Wallet/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Addtaskscr extends StatefulWidget {
  @override
  _AddtaskscrState createState() => _AddtaskscrState();
}

class _AddtaskscrState extends State<Addtaskscr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        /* padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
        // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        //color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 40, right: 40),
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Add",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                ),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "enter name"),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "amount"),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "enter name"),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                color: Colors.yellow,
                onPressed: () {},
                child: Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Changebalance extends StatefulWidget {
  final String currentOnlineUserId;
  Changebalance({this.oper, this.currentOnlineUserId});
  bool oper;
  @override
  _ChangebalanceState createState() => _ChangebalanceState();
}

class _ChangebalanceState extends State<Changebalance> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int valuechanged = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //git color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 40, right: 40),
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Change amount",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 30,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      validator: (input) {
                        final valueChanged = int.tryParse(input);
                        return valueChanged == 0
                            ? 'Input needs to be digits only'
                            : null;
                      },
                      onSaved: (input) {
                        valuechanged = int.parse(input);
                      },
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      color: Colors.yellow,
                      onPressed: () {
                        if (widget.oper) {
                          updateUserData();
                          //call function to deposit fund
                        } else {
                          //call function to withdraw amount
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.black54, fontSize: 25),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  updateUserData() async {
    DocumentSnapshot documentSnapshot =
        await usersReference.document(widget.currentOnlineUserId).get();
    User user = User.fromDocument(documentSnapshot);
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(user.currentwallet + valuechanged);
      usersReference.document(widget.currentOnlineUserId).updateData({
        "currentwallet": user.currentwallet + valuechanged,
      });
    }
  }
}
