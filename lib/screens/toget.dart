import 'package:flutter/material.dart';

class Toget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Cards(
                      amount: "5000",
                      name: "Jishnu",
                      date: "09-07-2020",
                    ),
                  );
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 50.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => takeImage(context),
          tooltip: 'Increment Counter',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

takeImage(mContext) {
  return showDialog(
    context: mContext,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          "Add details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        children: <Widget>[
          SimpleDialogOption(
            child: Text(
              "Capture Image with Camera",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
          ),
          SimpleDialogOption(
            child: Text(
              "Select Image from Gallary",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
          ),
          SimpleDialogOption(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () {},
          ),
        ],
      );
    },
  );
}

class Cards extends StatelessWidget {
  Cards({this.name, this.amount, this.date});
  final String name;
  final String amount;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Rs ${amount} \nfrom ${name}",
            style: TextStyle(color: Colors.white54, fontSize: 25),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text("Date:${date}",
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
    );
  }
}
