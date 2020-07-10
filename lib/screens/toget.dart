import 'package:Personal_Wallet/pages/homepage.dart';
import 'package:Personal_Wallet/screens/add.dart';
import 'package:Personal_Wallet/screens/example.dart';
import 'package:Personal_Wallet/user/firebase.dart';
import 'package:Personal_Wallet/user/userdata.dart';
import 'package:Personal_Wallet/widget/circularprogress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class Toget extends StatelessWidget {
//   final User gCurrentUser;
//   Toget({this.gCurrentUser});
//   @override
//   Widget build(BuildContext context) {

//   }
// }
class Toget extends StatefulWidget {
  final String gCurrentUser;
  Toget({this.gCurrentUser});
  @override
  _TogetState createState() => _TogetState();
}

class _TogetState extends State<Toget> {
  int notecount = 0;
  bool loading = true;
  String postOrientation = "grid";
  List<Post> postsList = [];
  void initState() {
    super.initState();

    getAllProfilePosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 40,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Personal Wallet",
                      style: TextStyle(color: Colors.white54, fontSize: 25),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "To Get",
                    style: TextStyle(color: Colors.white54, fontSize: 25),
                  ),
                ),

                displayProfilePost(),

                // Expanded(
                //   child: ListView.builder(
                //     physics: BouncingScrollPhysics(),
                //     // shrinkWrap: true,
                //     itemCount: 5,
                //     itemBuilder: (context, index) {
                //       return Align(
                //         alignment: Alignment.centerRight,
                //         child: Cards(
                //           amount: "5000",
                //           name: "Jishnu",
                //           date: "09-07-2020",
                //         ),
                //       );
                //     },
                //   ),
                // )
              ],
            ),
          ),
        ]),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("e");
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        AddUserPay(gCurrentUser: widget.gCurrentUser)));
          },
          tooltip: 'Increment Counter',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });
    QuerySnapshot querySnapshot = await postsReference
        .document(widget.gCurrentUser)
        .collection("usersPosts")
        .orderBy("timestamp", descending: true)
        .getDocuments();
    setState(() {
      loading = false;
      notecount = querySnapshot.documents.length;
      print(notecount);
      postsList = querySnapshot.documents
          .map((documentSnapshot) => Post.fromDocument(documentSnapshot))
          .toList();
    });
  }

  displayProfilePost() {
    if (loading) {
      return circularProgress();
    } else if (postsList.isEmpty) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child:
                  Icon(Icons.monetization_on, color: Colors.white, size: 200.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("No details",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } else if (postOrientation == "grid") {
      List<GridTile> gridTilesList = [];
      postsList.forEach((eachPost) {
        gridTilesList.add(GridTile(child: Cards(eachPost)));
      });
      return Column(children: gridTilesList);
      //   return Column(
      //   children: postsList,
      // );

    }
  }
}

class Cards extends StatelessWidget {
  final Post post;
  Cards(this.post);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        width: 350,
        color: Colors.black26,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: Colors.yellow,
              width: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Rs ${post.amount} \nfrom ${post.userwhom}",
              style: TextStyle(color: Colors.white54, fontSize: 15),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Date:${post.timestamp}",
                    style: TextStyle(color: Colors.white54, fontSize: 20)),
                FlatButton(
                  onPressed: () {
                    print("pressed");
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    height: 25,
                    width: 80,
                    color: Colors.yellow,
                    child: Text(
                      "Received",
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
