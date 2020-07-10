import 'package:Personal_Wallet/pages/homepage.dart';
import 'package:Personal_Wallet/screens/mainscreen.dart';
import 'package:Personal_Wallet/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class AddUserPay1 extends StatefulWidget {
  final String gCurrentUser;
  AddUserPay1({this.gCurrentUser});

  @override
  _AddUserPay1State createState() => _AddUserPay1State();
}

class _AddUserPay1State extends State<AddUserPay1> {
  final DateTime timestamp = DateTime.now();
  String postId = Uuid().v4();
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String userfriend;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {}), //clearPostInfo
        title: Text(
          "New details for give",
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => controlUploadAndSave(),
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 12.0,
            ),
          ),
          ListTile(
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: t1,
                decoration: InputDecoration(
                  hintText: "Write the user's name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.monetization_on,
              color: Colors.white,
              size: 36.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                controller: t2,
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  controlUploadAndSave() async {
    print("avando");

    savePostInfoToFireStore(l: t1.text, d: t2.text);

    t1.clear();
    t2.clear();
    Navigator.of(context).pop(
      MaterialPageRoute(builder: (context) => Homeui()),
    );
  }

  savePostInfoToFireStore({String l, String d}) {
    postsReference1
        .document(widget.gCurrentUser)
        .collection("usersPosts1")
        .document(postId)
        .setData({
      "postId": postId,
      "ownerId": widget.gCurrentUser,
      "timestamp": DateFormat('dd-MM-yyyy').format(timestamp),
      "amount": int.parse(d),
      "userwhom": l
    });
  }
}
