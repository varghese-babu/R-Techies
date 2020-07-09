import 'package:flutter/material.dart';

class Addtaskscr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "Add Task",
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
                  "Add",
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
