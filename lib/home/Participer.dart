// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, deprecated_member_use, unnecessary_string_interpolations

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home.dart';

class Participer extends StatefulWidget {
  // final String c;

  const Participer({
    Key? key,
    //  required this.c,
  }) : super(key: key);

  @override
  State<Participer> createState() => _ParticiperState();
}

class _ParticiperState extends State<Participer> {
  List<dynamic> actPar = [];
  List<dynamic> activite = [];

  Future getActPar() async {
    var res = await http.get(Uri.parse(
        'http://10.0.2.2:4040/Participer/participeruser/638da4d3f588da3579fa9d53'));
    int i = 0;
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      setState(() {
        actPar.addAll(jsonObj['data']);
      });

      print("part: ${jsonObj['data']}");
    }
    for (i; i < actPar.length; i++) {
      var id = await actPar[i]['activite'];
      var act = await getAct(id);
      setState(() {
        activite.add(act);
      });
    }
    print("activite: $activite");
  }

  Future getAct(id) async {
    var res = await http
        .get(Uri.parse('http://10.0.2.2:4040/Activite/activiteid?id=$id'));

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

  @override
  initState() {
    getActPar();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (activite.isEmpty) {
      return Center(
        child: Text("pas d'activité",
            style: (TextStyle(
              //  color: Color.fromARGB(255, 255, 2, 2),
              //fontWeight: FontWeight.bold,
              fontSize: 25,
            ))),
      );
    }
    return GridView.builder(
      //physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10),
      //  physics: NeverScrollableScrollPhysics(),
      itemCount: activite.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 300,
        childAspectRatio: 1.01,
      ),
      itemBuilder: (context, i) {
        return Card(
          margin: EdgeInsets.all(4.0),
          color: Color.fromARGB(255, 255, 255, 255),
          shadowColor: Color.fromARGB(255, 87, 146, 236),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
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
                                        c: "${activite[i]['categorie']}"),
                                  ));
                            },
                            child: Center(
                              // ignore: prefer_const_literals_to_create_immutables
                              child:
                                  // const Icon(Icons.format_list_bulleted, size: 100),
                                  Text("${activite[i]['categorie']}",
                                      style: (const TextStyle(
                                          color: Color.fromARGB(255, 2, 2, 2),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50))),
                            ),
                          ),
                        ),*/
              Padding(
                padding: const EdgeInsets.all(5),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("images/profile.jpg"),
                  ),
                  // ignore: duplicate_ignore
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("nom",
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("${activite[i]['nom']}",
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
                        //  Icon(Icons.schedule, color: Colors.red,),
                        // ignore: duplicate_ignore
                        Text(
                            "${activite[i]['date']}  À  ${activite[i]['temps']}",
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
                        Icon(Icons.place),
                        Text("${activite[i]['lieu']}",
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
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        deleteAct(activite[i]['_id']);

                        activite = [];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(selected: 1)));

                        //  print(    "favori ${i} =${produit[i]["favori"]}");
                      });
                    },
                    // check_circle

                    child: Text(
                      "Annuler",
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

                      onPrimary: Color.fromARGB(255, 110, 110, 110),
                      //onSurface: Colors.amber,
                      // shadowColor: Colors.amber,
                      fixedSize: Size(400, 70),
                      primary: Color.fromARGB(255, 234, 232, 232),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    //    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
