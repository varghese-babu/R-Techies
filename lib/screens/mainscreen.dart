import 'package:flutter/material.dart';
import 'package:Personal_Valet/components/round_iconbutton.dart';
import 'package:Personal_Valet/components/reusable_card.dart';
import 'package:Personal_Valet/screens/toget.dart';
import 'package:Personal_Valet/screens/addtask.dart';
import 'package:Personal_Valet/screens/togive.dart';

var balance;


class Homeui extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    balance=5000;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
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
                    "${balance}",
                    style: TextStyle(color: Colors.yellow, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundiconButton(
                  icon: Icons.add,
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (context)=>changebalance(oper: true,));
                  }
                ),
                SizedBox(
                  width: 40,
                ),
                RoundiconButton(
                  icon: Icons.minimize,
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (context)=>changebalance(oper: false,));
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
                          MaterialPageRoute(builder: (context) => Togive()));
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
}
