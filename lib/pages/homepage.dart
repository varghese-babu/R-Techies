import 'dart:async';

import 'package:Personal_Valet/pages/userpage.dart';
import 'package:Personal_Valet/pages/usersettings.dart';
import 'package:Personal_Valet/user/userdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final usersReference = Firestore.instance.collection("users");
  final DateTime timestamp = DateTime.now();
  User currentUser;
  String username;
  bool isSignedIn = false;
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: (gError) {
      print("Error Message: " + gError);
    });

    // gSignIn.signIn().then((gSignInAccount){
    //   controlSignIn(gSignInAccount);
    // });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFirestore();
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  loginUser() {
    googleSignIn.signIn();
  }

  logoutUser() {
    googleSignIn.signOut();
  }

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Personal Valet",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Bangers", fontSize: 40)),
            Text("tagline",
                style: TextStyle(color: Colors.redAccent, fontSize: 15)),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 15,
            ),
            _signInButton(),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //       width: 270.0,
            //       height: 65.0,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //         image: AssetImage("assets/google_signin_button.png"),
            //         fit: BoxFit.cover,
            //       ))),
            // ),

            SizedBox(
              height: 80,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.green,
                        height: 36,
                      )),
                ),
                Text(
                  "by",
                  style: TextStyle(fontSize: 15),
                ),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Divider(
                        color: Colors.green,
                        height: 36,
                      )),
                ),
              ],
            ),
            Text(
              "R Techies",
              style: TextStyle(color: Colors.amberAccent, fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return UserProfile();
    } else {
      return buildHomeScreen();
    }
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        loginUser();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveUserInfoToFirestore() async {
    final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await usersReference.document(gCurrentUser.id).get();

    if (!documentSnapshot.exists) {
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserSettings()));

      usersReference.document(gCurrentUser.id).setData({
        "id": gCurrentUser.id,
        "profileName": gCurrentUser.displayName,
        "username": username,
        "url": gCurrentUser.photoUrl,
        "email": gCurrentUser.email,
        "bio": "",
        "timestamp": timestamp,
      });

      documentSnapshot = await usersReference.document(gCurrentUser.id).get();
    }

    currentUser = User.fromDocument(documentSnapshot);
  }
}
