// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:join/home/Event.dart';
import 'package:join/home/chat.dart';
import 'package:line_icons/line_icons.dart';

import 'Accueil.dart';

//limport 'package:join/vendre/camera%20copy1.dart';

//import 'Accueil.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.selected}) : super(key: key);
  final int selected;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex = widget.selected;

  List<Widget> _widgetPages = <Widget>[
    Accueil(),
    Event(),
    Chatt(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 6,
                  activeColor: Color.fromARGB(255, 255, 255, 255),
                  iconSize: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Color(0xFF334657),
                  color: Color(0xFF334657),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      //S   text: 'Accueil',
                    ),
                    GButton(
                      icon: LineIcons.calendar,
                      // text: 'Recherche',
                    ),
                    GButton(
                      icon: Icons.person,
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
        body: Center(
          child: _widgetPages.elementAt(_selectedIndex),
        ));
  }
}
