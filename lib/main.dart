import 'package:Personal_Valet/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:Personal_Valet/screens/toget.dart';
import 'package:Personal_Valet/screens/mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Valet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      home: Homeui(),//Toget(),//Homepage(),
    );
  }
}