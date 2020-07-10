import 'package:Personal_Wallet/pages/homepage.dart';
import 'package:Personal_Wallet/user/userdata.dart';
import 'package:Personal_Wallet/widget/circularprogress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class Post {
//   final String postId;
//   final String ownerId;
//   final int amount;
//   final String userwhom;
//   final String timestamp;

//   Post({this.postId, this.ownerId, this.amount, this.userwhom, this.timestamp});

//   factory Post.fromDocument(DocumentSnapshot documentSnapshot) {
//     return Post(
//       postId: documentSnapshot["postId"],
//       ownerId: documentSnapshot["ownerId"],
//       amount: documentSnapshot["amount"],
//       userwhom: documentSnapshot["userwhom"],
//       timestamp: documentSnapshot["timestamp"],
//     );
//   }
//   @override
//   _PostState createState() => _PostState(
//         postId: this.postId,
//         ownerId: this.ownerId,
//       );
// }

class Post extends StatefulWidget {
  final String postId;
  final String ownerId;
  final int amount;
  final String userwhom;
  final String timestamp;

  Post({this.postId, this.ownerId, this.amount, this.userwhom, this.timestamp});

  factory Post.fromDocument(DocumentSnapshot documentSnapshot) {
    return Post(
      postId: documentSnapshot["postId"],
      ownerId: documentSnapshot["ownerId"],
      amount: documentSnapshot["amount"],
      userwhom: documentSnapshot["userwhom"],
      timestamp: documentSnapshot["timestamp"],
    );
  }

  @override
  _PostState createState() => _PostState(
      postId: this.postId,
      ownerId: this.ownerId,
      amount: this.amount,
      userwhom: this.userwhom,
      timestamp: this.timestamp);
}

class _PostState extends State<Post> {
  final String postId;
  final String ownerId;
  final int amount;
  final String userwhom;
  final timestamp;

  int likeCount;
  bool isLiked;
  bool showHeart = false;
  // final String currentOnlineUserId = currentUser?.id;
  _PostState(
      {this.postId, this.ownerId, this.amount, this.userwhom, this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
