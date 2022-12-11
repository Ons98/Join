// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable
import 'dart:convert';
import "dart:io";

import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:intl/date_symbol_data_local.dart';
//import 'package:mime/mime.dart';
//import 'package:open_filex/open_filex.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:uuid/uuid.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chatt extends StatefulWidget {
  Chatt({Key? key}) : super(key: key);

  @override
  State<Chatt> createState() => _ChattState();
}

class _ChattState extends State<Chatt> {
  // List<types.Message> _messages = [];
  //final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  TextEditingController msgInputController = TextEditingController();

  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
        'http://localhost:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            //  .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              child: Column(
            children: [
              Expanded(
                  flex: 8,
                  child: Container(
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            MessageItem(
                              sentByMe: false,
                            ),
                            MessageItem(
                              sentByMe: true,
                            ),
                          ],
                        );
                      },
                    ),
                  )),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 40),
                          cursorColor: Colors.blue,
                          controller: msgInputController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black)),
                              suffixIcon: Container(
                                  margin: EdgeInsets.only(
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black),
                                  child: IconButton(
                                    onPressed: () {
                                      sendMessage(msgInputController.text);
                                      msgInputController.text = "";
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ))))))
            ],
          ))),
    );
  }

  void sendMessage(String text) {}
}

class MessageItem extends StatelessWidget {
  const MessageItem({Key? key, required this.sentByMe}) : super(key: key);
  final bool sentByMe;
  @override
  Widget build(BuildContext context) {
    Color blue = Color.fromARGB(255, 182, 1, 237);

    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: sentByMe ? blue : Color.fromARGB(255, 194, 194, 194),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              "Bonjour",
              style: TextStyle(
                color: sentByMe ? Colors.white : Colors.black,
                fontSize: 35,
              ),
            ),
            SizedBox(
              height: 10,
              width: 10,
            ),
            Text(
              "11:00",
              style: TextStyle(
                  color:
                      (sentByMe ? Colors.white : Colors.black).withOpacity(0.7),
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
