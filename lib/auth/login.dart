// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, deprecated_member_use, unused_import

import 'package:flutter/material.dart';

import '../home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = TextEditingController();
  var password = TextEditingController();

  login() async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('POST', Uri.parse('http://192.168.0.6:4040/login'));
    request.body =
        json.encode({"email": email.text, "password": password.text});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
            ),

            Column(children: [
              Text("Se connecter",
                  style: TextStyle(
                    color: Color(0xFF334657),
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                "Remplie ces informations ",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ]),
            //    ),
            Container(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "Veuillez entrer votre Email";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      //  obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black))),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrer un mot de passe";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(width: 3, color: Color(0xFF334657)),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20, bottom: 40),
                      child: InkWell(
                        child: Text("Mot de passe oublié ?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                        onTap: () {
                          Navigator.of(context).pushNamed("resetpass");
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();

                          Navigator.of(context).pushNamed("homeP");
                        }
                      },

                      child: Text(
                        "Se Connecter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(350, 60),
                        primary: Color(0xFF334657),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ), //color: Colors.black,
                      //    ),
                    ),
                    //   ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous n'avez pas un compte ! ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("signUp");
                  },
                  child: Text(
                    "Créer un compte",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
/*
            Row(
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.radio_button_unchecked,
                  size: 15,
                ),
                Icon(
                  Icons.radio_button_unchecked,
                  size: 15,
                ),
                Icon(
                  Icons.radio_button_unchecked,
                  size: 15,
                ),
                Icon(
                  Icons.radio_button_unchecked,
                  size: 15,
                ),
                Icon(
                  Icons.radio_button_unchecked,
                  size: 15,
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                ),
              ],
            ),
            */
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
