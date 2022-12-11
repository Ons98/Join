// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _pass = TextEditingController();
  var _confirmPass = TextEditingController();

  TextEditingController nom = TextEditingController();
  TextEditingController email = TextEditingController();

  register() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.0.6:4040/registerutilisateur'));
    request.body = json
        .encode({"nom": nom.text, "email": email.text, "password": _pass.text});
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("S'inscrire",
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF334657),
                  )),
              Text(
                "Remplie ces informations ",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF334657),
                ),
              ),
            ]),
            Container(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nom,
                      style: TextStyle(fontSize: 20),
                      //   keyboardType: TextInputType.emailAddress,
                      //   obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            RegExp(r"^([a-zA-Z]{2,}\\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\\s?([a-zA-Z]{1,})?)")
                                .hasMatch(value)) {
                          return "Veuillez entrer votre nom et prénom";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Nom et Prenom",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFF334657)))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      style: TextStyle(fontSize: 20),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "Veuillez entrer votre Email";
                        } else {
                          return null;
                        }
                      },
                      //  obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFF334657)))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _pass,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrer un mot de passe";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Mot de passe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(width: 3, color: Colors.black))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _confirmPass,
                      obscureText: true,
                      validator: (value) {
                        if ((value!.isEmpty) || (value != _pass.text)) {
                          return "Veuillez entrer le même mot de passe";
                        } else {
                          return null;
                        }
                      },
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Confirmer mot de passe",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 3, color: Color(0xFF334657)))),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  register();
                  Navigator.of(context).pushNamed("login");
                }
              },

              child: Text(
                "S'inscrire",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Vous avez déjà un compte ! ",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("login");
                  },
                  child: Text(
                    "se connecter",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
