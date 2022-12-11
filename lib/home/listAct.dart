// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations, duplicate_ignore, unused_import, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

class Act extends StatefulWidget {
  final String c;

  const Act({
    Key? key,
    required this.c,
  }) : super(key: key);

  @override
  State<Act> createState() => _ActState();
}

class _ActState extends State<Act> {
  Future getAct() async {
    var res = await http.get(Uri.parse(
        'http://10.0.2.2:4040/Activite/activitenom?nom=${widget.c}&utilisateur=638da4d3f588da3579fa9d53'));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);

      return jsonObj['data'];
    }
  }

  deleteAct(id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://10.0.2.2:4040/Participer/deleteParticiper?&activite=$id&utilisateur=638da4d3f588da3579fa9d53'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  CreatePart(act) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://10.0.2.2:4040/Participer/createParticiper'));
    request.body = json
        .encode({"activite": act, "utilisateur": "638da4d3f588da3579fa9d53"});
    request.headers.addAll(headers);
  }

  String s = "";
  // ignore: non_constant_identifier_names
  bool Participate = false;
  @override
  Widget build(BuildContext context) {
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
                  if (snapshot.data.isEmpty) {
                    return Center(
                      child: Text("pas d'activité",
                          style: (TextStyle(
                            //  color: Color.fromARGB(255, 255, 2, 2),
                            //fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ))),
                    );
                  } else {
                    return GridView.builder(
                        padding: EdgeInsets.all(10),
                        //  physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 300,
                        ),
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(4.0),
                            color: Color.fromARGB(255, 255, 255, 255),
                            shadowColor: Color.fromARGB(255, 87, 146, 236),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage:
                                              AssetImage("images/profile.jpg"),
                                        ),
                                        // ignore: duplicate_ignore
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text("nom",
                                                // ignore: prefer_const_constructors
                                                style: (TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  //   fontWeight: FontWeight.bold,
                                                  fontSize: 30,
                                                ))),
                                          ],
                                        ),
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("${snapshot.data[index]['nom']}",
                                              // ignore: prefer_const_constructors
                                              style: (TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                              ))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          //  Icon(Icons.schedule, color: Colors.red,),
                                          Text(
                                              "${snapshot.data[index]['date']}  À  ${snapshot.data[index]['temps']}",
                                              // ignore: prefer_const_constructors
                                              style: (TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 2, 2),
                                                //  fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.place),
                                          Text(
                                              "${snapshot.data[index]['lieu']}",
                                              // ignore: prefer_const_constructors
                                              style: (TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                //  fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                              ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (s == "Participer") {
                                            // Participate = false;
                                            CreatePart(
                                                snapshot.data[index]['_id']);
                                            s = "Annuler";
                                            //  activite[index[i]]['etat'] = "false";
                                            //   index = [];
                                          } else {
                                            //    Participate = true;
                                            deleteAct(
                                                snapshot.data[index]['_id']);
                                            s = "Participer";
                                            //     activite[index[i]]['etat'] = "true";

                                            //     index = [];
                                          }
                                        });
                                      },
                                      // check_circle

                                      child: Text(
                                        "$s",
                                        style: TextStyle(
                                          //   fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),

                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                          width: 0.2,
                                          color: Color.fromARGB(255, 1, 1, 1),
                                        ),
                                        elevation: 3,

                                        onPrimary:
                                            Color.fromARGB(255, 110, 110, 110),
                                        //onSurface: Colors.amber,
                                        // shadowColor: Colors.amber,
                                        fixedSize: Size(400, 70),
                                        primary:
                                            Color.fromARGB(255, 234, 232, 232),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                      ),
                                      //    ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                } else {
                  return CircularProgressIndicator();
                }
              })),
    );
  }
}
