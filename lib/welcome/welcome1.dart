// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:join/auth/login.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF334657), // #334657 #384454
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Text(
                        "JOIN..",
                        style: TextStyle(
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 25,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.circle,
                            size: 25,
                            color: Color.fromARGB(120, 158, 165, 203),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF334657), //rgba(243,232,218,255)
              ),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: Container(height: 300)),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Bienvenu(e) cher(e) Mme/Mr  ….",
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //Expanded(flex: 1, child: Container()),
                    Expanded(
                      flex: 1,
                      child: Row(
                        // mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            size: 25,
                            color: Color.fromARGB(120, 158, 165, 203),
                          ),
                          Icon(
                            Icons.circle,
                            size: 25,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //login Page
            Login(),
          ],
        ),
      ),
    );
  }
}
