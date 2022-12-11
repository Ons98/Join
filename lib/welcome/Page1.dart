// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:join/welcome/welcome1.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //    context, MaterialPageRoute(builder: (context) => WelcomePage()));
      // WelcomePage();
      Navigator.of(context).pushNamed("welcome1");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF), //rgba(254,249,234,255),//
//fef9ea
            //  image: DecorationImage(
            //  image: AssetImage("images/logo.png"),
            //  ),
          ),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF), //rgba(254,249,234,255),//
//fef9ea
                image: DecorationImage(
                  image: AssetImage("images/logo.png"),
                ),
              ),
            ),
          ])),
    );
  }
}
/*
onTap: () {
        Navigator.of(context).pushNamed("welcome1");
      },
      */
