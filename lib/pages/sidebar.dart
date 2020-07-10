import 'package:Personal_Wallet/pages/homepage.dart';
import 'package:Personal_Wallet/pages/userpage.dart';
import 'package:Personal_Wallet/screens/mainscreen.dart';
import 'package:Personal_Wallet/user/userdata.dart';
import 'package:Personal_Wallet/widget/circularprogress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Foldable extends StatefulWidget {
  String userProfileId;

  Foldable({this.userProfileId});
  @override
  _FoldableState createState() => _FoldableState();
}

class _FoldableState extends State<Foldable> {
  FSBStatus drawerStatus;

  createProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfileId).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(dataSnapshot.data);
        return ListTile(
          title: Text(
            user.profileName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                fontFamily: "Signatra"),
          ),
          subtitle: Text(
            user.email,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.url),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.grey,
          drawer: CustomDrawer(
              userProfile: widget.userProfileId,
              closeDrawer: () {
                setState(() {
                  drawerStatus = FSBStatus.FSB_CLOSE;
                });
              }),
          screenContents: Homeui(
            userProfileId: widget.userProfileId,
          ),
          status: drawerStatus,
        ),
        floatingActionButton: Align(
          alignment: Alignment(1, -0.9),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }, //child:Container(
            //       width: MediaQuery.of(context).size.width *.20,

            //       child: Align(
            //         alignment: Alignment.topRight,
            //         child: Container(
            //           alignment: Alignment.center,
            //           height: 52,
            //           width: 52,
            //           decoration: BoxDecoration(
            //             color: Color(0xFFF2BEA1),
            //             shape: BoxShape.circle,
            //           ),
            //          child: AnimatedIcon(
            //       progress: _animationController.view,
            //       icon: AnimatedIcons.menu_close,
            //       color: Color(0xFF1BB5FD),
            //       size: 25,
            //     ),
            //         ),
            //       ),
            //     ),

            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white)),
              alignment: Alignment.centerLeft,
              child: Center(
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Colors.deepOrange,
        //     child: Icon(Icons.menu,color: Colors.white,),
        //     onPressed: () {
        //       setState(() {
        //         drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
        //       });
        //     }),
      ),
    );
  }
}

class CustomDrawer extends StatefulWidget {
  final Function closeDrawer;
  final userProfile;

  CustomDrawer({Key key, this.closeDrawer, this.userProfile}) : super(key: key);
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  createProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfile).get(),
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }
        User user = User.fromDocument(dataSnapshot.data);
        return ListTile(
          title: Text(
            user.profileName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                fontFamily: "Signatra"),
          ),
          subtitle: Text(
            user.email,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(user.url),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: ListView(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.black26,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[createProfileTopView()],
              )),

          // Divider(
          //   height: 1,
          //   color: Colors.grey,
          // ),
          // ListTile(
          //   onTap: () {
          //     debugPrint("Tapped Payments");
          //   },
          //   leading: Icon(Icons.payment),
          //   title: Text("Payments"),
          // ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () => logoutUser(),
            leading: Icon(Icons.exit_to_app),
            title: Text(
              "Log Out",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  logoutUser() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    Navigator.of(context).push(new MaterialPageRoute<Homepage>(
      builder: (BuildContext context) {
        return new Homepage();
      },
    ));
  }

  gotoSettings() {}
}
