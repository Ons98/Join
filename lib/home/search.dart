// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
//  List act = [];
  Future getAct() async {
    var res = await http.get(Uri.parse(
        'http://10.0.2.2:4040/Activite/activiteuser?utilisateur=638da4d3f588da3579fa9d53'));

    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj['data'];
      /*   setState(() {
         act.addAll(jsonObj['data']);
      });
      
     */

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FutureBuilder(
                future: getAct(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${snapshot.data[index]['temps']}"),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}
