// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:join/home/MonAct.dart';
import 'package:join/home/Participer.dart';

import 'activités.dart';

class Event extends StatefulWidget {
  Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 20,
          elevation: 3,
          backgroundColor: Colors.white,
          bottom: TabBar(
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 22),
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              // indicatorPadding: EdgeInsets.all(20),
              tabs: [
                Tab(
                  child: Text("Mes activités",
                      style: (TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
                ),
                Tab(
                  child: Text("Activités participées",
                      style: (TextStyle(
                        fontWeight: FontWeight.bold,
                      ))),
                ),
              ]),
        ),
        body: TabBarView(children: [
          MonAct(),
          Participer(),
        ]),
      ),
    );
  }
}
