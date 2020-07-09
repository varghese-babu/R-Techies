import 'package:Personal_Valet/pages/homepage.dart';
import 'package:Personal_Valet/user/userdata.dart';
import 'package:Personal_Valet/widget/circularprogress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Personal_Valet/components/round_iconbutton.dart';
import 'package:Personal_Valet/components/reusable_card.dart';
import 'package:Personal_Valet/screens/toget.dart';
import 'package:Personal_Valet/screens/addtask.dart';

var balance;

class Homeui extends StatefulWidget {
  final String userProfileId;
  Homeui({this.userProfileId});
  @override
  _HomeuiState createState() => _HomeuiState();
}

class _HomeuiState extends State<Homeui> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int valuechanged = 0;
  createProfileTopView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: usersReference.document(widget.userProfileId).get(),
        builder: (context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return circularProgress();
          }
          User user = User.fromDocument(dataSnapshot.data);
          return Padding(
            padding: EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your Balance",
                        style: TextStyle(color: Colors.yellow, fontSize: 30),
                      ),
                      Text(
                        "${user.currentwallet}",
                        style: TextStyle(color: Colors.yellow, fontSize: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String currentOnlineUserId = widget.userProfileId;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            createProfileTopView(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundiconButton(
                    icon: Icons.add,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => changebalance(
                                oper: true,
                                currentOnlineUserId: currentOnlineUserId,
                              ));
                    }),
                SizedBox(
                  width: 40,
                ),
                RoundiconButton(
                  icon: Icons.minimize,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => changebalance(
                              oper: false,
                              currentOnlineUserId: currentOnlineUserId,
                            ));
                  },
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Toget()));
                    },
                    child: Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "To Get",
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Toget()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black26,
                      ),
                      height: 150,
                      child: Align(
                          alignment: Alignment.center, child: Text("To Give")),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  changebalance({bool oper, String currentOnlineUserId}) {
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
                        if (oper) {
                          updateUserData(currentOnlineUserId);
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

  updateUserData(currentOnlineUserId) async {
    DocumentSnapshot documentSnapshot =
        await usersReference.document(currentOnlineUserId).get();
    User user = User.fromDocument(documentSnapshot);
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(user.currentwallet + valuechanged);
      usersReference.document(currentOnlineUserId).updateData({
        "currentwallet": user.currentwallet + valuechanged,
      });
      setState(() {});
    }
  }
}
