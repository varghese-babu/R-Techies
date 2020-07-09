import 'package:flutter/material.dart';

class Addtaskscr extends StatefulWidget {
  @override
  _AddtaskscrState createState() => _AddtaskscrState();
}

class _AddtaskscrState extends State<Addtaskscr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
       /* padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
        // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        //color: Color(0xFF757575),
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
                "Add",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 30,
                ),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "enter name"),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "amount"),
              ),
              TextField(
                enabled: true,
                //cursorColor: Colors.black,
                //textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: "enter name"),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                color: Colors.yellow,
                onPressed: () {},
                child: Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class changebalance extends StatelessWidget {
  changebalance({this.oper});
  bool oper;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF757575),
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
            TextField(
              
              enabled: true,
              //cursorColor: Colors.black,
              
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              color: Colors.yellow,
              onPressed: () {
                if(oper){
                  //call function to deposit fund
                }
                else{
                  //call function to withdraw amount
                }
              },
              child: Text(
                "Add",
                style: TextStyle(color: Colors.black54, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}