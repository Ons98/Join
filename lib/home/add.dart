// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  /* {
      'value': 'café',
      'label': 'café',
      // 'icon': Icon(Icons.stop),
    },
    {
      'value': 'marche',
      'label': 'marche',
      //     'icon': Icon(Icons.fiber_manual_record),
      //  'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'pique-nique',
      'label': 'pique-nique',
      //  'enable': false,
      //   'icon': Icon(Icons.grade),
    },
  ];*/
  TextEditingController? _controller;

  CreateAct() async {
    String k = "";
    for (int i = 0; i < _items.length; i++) {
      if (_items[i]['value'] == _value) {
        k = _items[i]['label'];
      }
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.0.6:4040/Activite/createActivite'));
    request.body = json.encode({
      "activitePub": _value,
      "utilisateur": "638da4d3f588da3579fa9d53",
      "date": dateinput.text,
      "temps": timeinput.text,
      "lieu": lieu.text,
      "description": desc.text,
      "nom": k
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("k=$_value");
    } else {
      print(response.reasonPhrase);
    }
  }

  List<Map<String, dynamic>> _items = [];
  List act = [];
  Map User = {};
  Map<String, dynamic> valueM = {};
  Future getAct() async {
    var res = await http.get(
        Uri.parse('http://10.0.2.2:4040/Publieractivite/getAllPubActivites'));
    int i = 0;
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      setState(() {
        act.addAll(jsonObj['data']);
      });
      for (i; i < act.length; i++) {
        /* valueM['value'] = act[i]['_id'];
        valueM['label'] = act[i]['nom'];
        print(valueM);
*/
        _items.add({'value': act[i]['_id'], 'label': act[i]['nom']});
      }
      print("item: $_items");
    }
  }

  Future getUser() async {
    var res = await http.get(Uri.parse('http://10.0.2.2:4040/profile'));
    int i = 0;
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      setState(() {
        User.addAll(jsonObj['data']);
      });
      print(" user $User");
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  initState() {
    getAct();
    getUser();

    dateinput.text = ""; //set the initial value of text field
    //  var timeinput;
    timeinput.text = "";
    list.text = "";

    super.initState();
  }

  late String _value;
  TextEditingController dateinput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController lieu = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController list = TextEditingController();
  /*
  insert() async {
    var res = await http.post("http", body: {
      "temps": timeinput,
      "date": dateinput,
      "lieu": lieu,
      "desc": desc,
      "category": list
    });
  }*/

  final _formKey = GlobalKey<FormState>();

  //void _onChanged(dynamic val) => debugPrint(val.toString());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 5,
        title: const Text("Publier activité",
            style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Color(0xFF334657),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(35),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /*
                  TextFormField(
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
                 */
                  SizedBox(
                    height: 30,
                  ),
                  SelectFormField(
                    controller: _controller,
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                    type: SelectFormFieldType.dropdown, // or can be dialog
                    initialValue: 'circle',
                    icon: Icon(
                      Icons.list,
                      size: 35,
                    ),
                    labelText: 'Choisir une activité',
                    items: _items,
                    onChanged: (val) => setState(() => _value = val),
                    onSaved: (val) => setState(() => _value = val ?? ''),
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                    controller:
                        dateinput, //editing controller of this TextField

                    decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_today,
                          size: 35,
                        ), //icon of text field
                        labelText: "Date" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                    controller:
                        timeinput, //editing controller of this TextField
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.timer,
                          size: 35,
                        ), //icon of text field
                        labelText: "Temps" //label text of field
                        ),
                    readOnly:
                        true, //set it true, so that user will not able to edit text
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        print(pickedTime.format(context)); //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm()
                            .parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime =
                            DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.

                        setState(() {
                          timeinput.text =
                              formattedTime; //set the value of text field.
                        });
                      } else {
                        print("Time is not selected");
                      }
                    },
                  ),
                  TextFormField(
                    controller: lieu,
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.place,
                        size: 35,
                      ), //icon of text field
                      labelText: "Lieu", //label text of field
                    ),
                  ),
                  TextFormField(
                    controller: desc,
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.list_alt,
                        size: 35,
                      ), //icon of text field
                      labelText: "Description", //label text of field
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //    insert();
                        CreateAct();
                        //
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text("succès",
                                style: (TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color.fromARGB(195, 16, 152, 3),
                                ))),
                            content: Text("activité ajoutée avec succès",
                                style: (TextStyle(
                                  //  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ))),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK",
                                      style: (TextStyle(
                                        //    color: Color.fromARGB(255, 255, 2, 2),
                                        //  fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      )))),
                            ],
                          ),
                        );
                        //Navigator.of(context).pushNamed("monact");
                      }
                    },

                    child: const Text(
                      "Publier",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 70),
                      backgroundColor: const Color(0xFF334657),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ), //color: Colors.black,
                    //    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
