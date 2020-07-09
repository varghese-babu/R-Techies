import 'package:Personal_Valet/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfile extends StatefulWidget {
  final String userProfileId;
  UserProfile({this.userProfileId});
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  void signOutGoogle() async {
    await googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Homepage()),
        (Route<dynamic> route) => false);
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        OutlineButton(
          onPressed: () => signOutGoogle(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Text("Signout"),
        )
      ],
    ));
  }
}
