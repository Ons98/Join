import 'package:flutter/material.dart';
import 'package:join/auth/login.dart';
import 'package:join/auth/resetpassword.dart';
import 'package:join/auth/signUp.dart';
import 'package:join/home/Accueil.dart';
import 'package:join/home/MonAct.dart';
import 'package:join/welcome/Page1.dart';
import 'package:join/welcome/welcome1.dart';
import 'package:join/home/add.dart';
import 'package:join/home/home.dart';
import 'package:join/home/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Join',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      routes: {
        "accueil": (context) => Accueil(),
        "home": (context) => HomePage(),
        "homeP": (context) => Home(selected: 0),
        "welcome1": (context) => WelcomePage(),
        "login": (context) => Login(),
        "signUp": (context) => SignUp(),
        "resetpass": (context) => ResetPass(),
        "add": (context) => Add(),
        "monact": (context) => const MonAct(),
      },
    );
  }
}
