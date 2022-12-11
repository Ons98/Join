// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unused_import, sized_box_for_whitespace, deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:join/home/activit%C3%A9s.dart';
import 'package:join/home/chat.dart';

import 'home.dart';
import 'package:line_icons/line_icons.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("add");
                  },
                  child: Row(children: [
                    Icon(Icons.add, size: 40),
                    Text(
                      "Publier une activité",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    )
                  ]),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(390, 170),
                    primary: Color(0xFF334657),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shadowColor: Color(0xFFC5D4EB),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 200,
                  width: 350,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Activite(),
                          ));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Icon(Icons.format_list_bulleted, size: 100),
                        Text("Activités",
                            style: (TextStyle(
                                //color: Color.fromARGB(255, 2, 96, 236),
                                fontWeight: FontWeight.bold,
                                fontSize: 30))),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shadowColor: Color(0xFFC5D4EB),
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 200,
                  width: 350,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Chatt(),
                          ));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Icon(Icons.chat, size: 100),
                        Text("Chat",
                            style: (TextStyle(
                                //color: Color.fromARGB(255, 2, 96, 236),
                                fontWeight: FontWeight.bold,
                                fontSize: 30))),
                      ],
                    ),
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
