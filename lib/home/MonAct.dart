// ignore_for_file: prefer_const_constructors, duplicate_ignore, deprecated_member_use, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:join/home/Event.dart';
import 'package:join/home/modifier.dart';

import 'user.dart';

import 'package:http/http.dart' as http;

import 'home.dart';

class MonAct extends StatefulWidget {
  // final String c;

  const MonAct({
    Key? key,
    //  required this.c,
  }) : super(key: key);

  @override
  State<MonAct> createState() => _MonActState();
}

class _MonActState extends State<MonAct> {
  // List index = [];

  // List act = [];
  Future getAct() async {
    var res = await http.get(Uri.parse(
        'http://10.0.2.2:4040/Activite/activiteuser?utilisateur=638da4d3f588da3579fa9d53'));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj['data'];
      //   setState(() {
      //   index.addAll(jsonObj['data']);
      //});
    }
  }

  Future get(id) async {
    var res = await http
        .get(Uri.parse('http://10.0.2.2:4040/Publieractivite/getActid?id=$id'));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj['data']['nom'];
      //   setState(() {
      //   index.addAll(jsonObj['data']);
      //});
    }
  }

  int i = 0;
  String s = "Annuler";
  // ignore: non_constant_identifier_names
  bool Participate = false;
  @override
  Widget build(BuildContext context) {
    /* for (var j = 0; j < activite.length; j++) {
      if (activite[j]["sup"] == "false") {
        index.add(j);
      }
    }
    if (index.isEmpty) {
      return Center(
        child: Text("pas d'activité",
            style: (TextStyle(
              //  color: Color.fromARGB(255, 255, 2, 2),
              //fontWeight: FontWeight.bold,
              fontSize: 25,
            ))),
      );
    }*/
    return FutureBuilder(
        future: getAct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              //  physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                mainAxisExtent: 300,
                childAspectRatio: 1.01,
              ),
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(4.0),
                  color: Color.fromARGB(255, 244, 240, 240),
                  shadowColor: Color.fromARGB(255, 87, 146, 236),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 40,
                      ),
                      /*Container(
                            height: 50,
                            width: 300,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Act(
                                          c: "${activite[index[i]]['categorie']}"),
                                    ));
                              },
                              child: Center(
                                // ignore: prefer_const_literals_to_create_immutables
                                child:
                                    // const Icon(Icons.format_list_bulleted, size: 100),
                                    Text("${activite[index[i]]['categorie']}",
                                        style: (const TextStyle(
                                            color: Color.fromARGB(255, 2, 2, 2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50))),
                              ),
                            ),
                          ),*/
                      /*
                Padding(
                  padding: const EdgeInsets.all(5),
                  child:
                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(activite[index[i]]["author"]),
                    ),
                    // ignore: duplicate_ignore
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${activite[index[i]]['authorN']}",
                            // ignore: prefer_const_constructors
                            style: (TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              //   fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ))),
                      ],
                    ),
                  ]),
                  
                ),
                */
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //  Icon(Icons.schedule, color: Colors.red,),
                                Text(
                                    "${snapshot.data[index]['date']}  À  ${snapshot.data[index]['temps']}",
                                    // ignore: prefer_const_constructors
                                    style: (TextStyle(
                                      color: Color.fromARGB(255, 255, 2, 2),
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
                                Text(snapshot.data[index]['nom'],
                                    // ignore: prefer_const_constructors
                                    style: (TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
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
                                Icon(Icons.place),
                                Text("${snapshot.data[index]['lieu']}",
                                    // ignore: prefer_const_constructors
                                    style: (TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
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
                                Text(" 'nb'",
                                    style: (TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      //  fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ))),
                                Text("   participant(s)",
                                    // ignore: prefer_const_constructors
                                    style: (TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Modifier(
                                            id: snapshot.data[index]['_id'],
                                            user: snapshot.data[index]
                                                ['utilisateur'],
                                            act: snapshot.data[index]
                                                ['activitePub'],
                                            temps: snapshot.data[index]
                                                ['temps'],
                                            date: snapshot.data[index]['date'],
                                            desc: snapshot.data[index]
                                                ['description'],
                                            lieu: snapshot.data[index]['lieu']),
                                      ));
                                  //     setState(() {
                                  // activite[index[i]]['etat'] = "false";

                                  //index = [];

                                  //  print(    "favori ${index[i]} =${produit[index[i]]["favori"]}");
                                  //     });
                                },
                                // check_circle

                                child: Text(
                                  "modifier",
                                  style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),

                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Color.fromARGB(255, 110, 110, 110),
                                  side: BorderSide(
                                    width: 0.2,
                                    color: Color.fromARGB(255, 2, 91, 21),
                                  ),
                                  elevation: 3,
                                  //onSurface: Colors.amber,
                                  // shadowColor: Colors.amber,
                                  fixedSize: Size(150, 70),
                                  primary: Color.fromARGB(255, 108, 221, 249),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                //    ),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    confirmDelete(snapshot.data[index]['_id']),

                                child: Text(
                                  "supprimer",
                                  style: TextStyle(
                                    //   fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),

                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 0.2,
                                    color: Color.fromARGB(255, 106, 2, 2),
                                  ),
                                  elevation: 3,

                                  onPrimary: Color.fromARGB(255, 110, 110, 110),
                                  //onSurface: Colors.amber,
                                  // shadowColor: Colors.amber,
                                  fixedSize: Size(150, 70),
                                  primary: Color.fromARGB(255, 250, 154, 154),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                //    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  confirmDelete(idd) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("supprimer",
                  style: (TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ))),
              content: Text("voulez-vous vraiment supprimer cette activité?",
                  style: (TextStyle(
                    //    color: Color.fromARGB(255, 255, 2, 2),
                    //  fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ))),
              actions: [
                TextButton(
                    onPressed: () async {
                      var request = http.Request(
                          'DELETE',
                          Uri.parse(
                              'http://10.0.2.2:4040/Activite/deleteActivite/$idd'));
                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                      } else {
                        print(response.reasonPhrase);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(selected: 1)));
                    },
                    child: Text("Oui",
                        style: (TextStyle(
                          color: Color.fromARGB(255, 255, 2, 2),
                          //  fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Non",
                        style: (TextStyle(
                          //    color: Color.fromARGB(255, 255, 2, 2),
                          //  fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )))),
              ],
            ));
  }
}
