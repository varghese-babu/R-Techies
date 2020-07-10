import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Personal_Valet/pages/homepage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSettings extends StatefulWidget {
  final String userProfileId;
  final String userName;
  UserSettings({this.userProfileId, this.userName});
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usersReference = Firestore.instance.collection("users");
  String username;
  final DateTime timestamp = DateTime.now();

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();

      SnackBar snackBar = SnackBar(content: Text("Welcome " + username));
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            'User settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, bottom: 17, right: 25),
                  child: Container(
                    width: (MediaQuery.of(context).size.width / 2) - 50,
                    child: TextFormField(
                      initialValue: widget.userName,
                      style: TextStyle(color: Colors.white, fontSize: 17),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter username";
                        }
                      },
                      onSaved: (val) => username = val,
                      decoration: InputDecoration(
                        labelText: "Enter Username",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70),
                  child: submitButton(),
                ),
              ],
            )));
  }

  Widget submitButton() {
    return OutlineButton(
      onPressed: () => submit(),
      splashColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
