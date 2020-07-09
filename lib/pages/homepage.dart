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

  Scaffold userSettings() {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'User settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Form(
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
                  initialValue: returnName(),
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

  @override
  Widget build(BuildContext context) {
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

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().whenComplete(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return navigationtoProfile();
              },
            ),
          );
        });
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

  String returnName() {
    final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
    return gCurrentUser.displayName;
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

  saveUserInfoToFirestore() async {
    final GoogleSignInAccount gCurrentUser = googleSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await usersReference.document(gCurrentUser.id).get();

    // if (!documentSnapshot.exists) {
    //   final username = await Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => CreateAccountPage()));

    usersReference.document(gCurrentUser.id).setData({
      "id": gCurrentUser.id,
      "profileName": gCurrentUser.displayName,
      "username": username,
      "url": gCurrentUser.photoUrl,
      "email": gCurrentUser.email,
      "timestamp": timestamp,
    });

    documentSnapshot = await usersReference.document(gCurrentUser.id).get();
    // }

    currentUser = User.fromDocument(documentSnapshot);
  }

  submit() {
    saveUserInfoToFirestore();
  }

  navigationtoProfile() {
    bool userbool;

    print(userbool);
    if (userbool) {
      return userSettings();
    } else {
      return UserProfile();
    }
  }
}
