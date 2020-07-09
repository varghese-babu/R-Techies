import 'package:Personal_Valet/user/firebase.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  // displayFullPost(context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               PostScreenPage(postId: post.postId, userId: post.ownerId)));
  // }

  final Post post;
  PostTile(this.post);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          // displayFullPost(context);
        }, //displayFullPost(context),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: new BoxDecoration(),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(post.userwhom),
                  Text("${post.amount}"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
