// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, unused_import, prefer_const_constructors_in_immutables, file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';

import 'user.dart';
import 'listAct.dart';

class Activite extends StatefulWidget {
  Activite({Key? key}) : super(key: key);

  @override
  State<Activite> createState() => _ActiviteState();
}

class _ActiviteState extends State<Activite> {
  //List index = [];
  //int i = 0;

  Future getAct() async {
    var res = await http.get(
        Uri.parse('http://10.0.2.2:4040/Publieractivite/getAllPubActivites'));
    int i = 0;
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);

      return jsonObj['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    /* for (var j = 0; j < activite.length; j++) {
      index.add(j);
    }*/

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            elevation: 5,
            /* iconTheme: IconThemeData(
          color: Colors.black,
        ), */
            title: const Text("activités",
                style: TextStyle(color: Colors.white, fontSize: 30)),
            backgroundColor: Color(0xFF334657),
          ),
          body: FutureBuilder(
              future: getAct(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      padding: EdgeInsets.all(20),
                      //  physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 200,
                      ),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Color.fromARGB(255, 116, 211, 243),
                          shadowColor: Color.fromARGB(255, 87, 146, 236),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            height: 50,
                            width: 300,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Act(
                                          c: "${snapshot.data[index]['nom']}"),
                                    ));
                              },
                              child: Center(
                                // ignore: prefer_const_literals_to_create_immutables
                                child:
                                    // const Icon(Icons.format_list_bulleted, size: 100),
                                    Text("${snapshot.data[index]['nom']}",
                                        style: (const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50))),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
