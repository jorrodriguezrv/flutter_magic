import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_api_list/profile.dart';
import 'package:flutter_api_list/navBar.dart';
import 'package:camera/camera.dart';




enum SelectedPage    {
  Transaction,
  Profile,
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {

  late List data = [];
  List types = [];

  Future<String> getData() async {
    var response = await http.get(
      //  Uri.parse("https://jsonplaceholder.typicode.com/photos"),

        Uri.parse("https://jrsburgerbuilder-default-rtdb.firebaseio.com/accountType.json"),
        headers: {
          "Accept": "application/json"
        }
    );

    final json = "[" + response.body + "]";
    //  print(jsonDecode(json));

    this.setState(() {
      data = jsonDecode(json);
      types = data[0].keys.toList();
    });

    print(data);
    print(types);
    print(data[0].length);
    print(data[0][1]);

    return "Success!";
  }


  Future<String> postData() async {
    var response = await http.post(
        Uri.parse("https://reqres.in/api/users"),
        headers: {
          "Accept": "application/json"
        }
    );

    print(response.body);

    return "Success!";
  }



  int _selectedIndex = 0;

  @override
  void initState() {
    this.getData();
  }

  void _onItemTapped(int index) {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text("Red-Mint"),
          centerTitle: true,),
        body: new ListView.builder(
          shrinkWrap: true,
          itemCount: types == null ? 0 : types.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
                child:
                ExpansionTile(
                  title: Text(
                      types[index]
                  ),
                  children:
                  <Widget>[

                    new ListView.builder(
                        shrinkWrap: true,
                        itemCount:  data[0][types[index]] == null ? 0 :  data[0][types[index]].length,
                        itemBuilder: (BuildContext context, int index1) {

                          return new Card(
                              child:

                              ExpansionTile(
                                title: Text(
                                    data[0][types[index]][index1]
                                ),
                                children:
                                <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        "02/12/2021     \$500",//data[0]["credit"][index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),

                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:


                                          GestureDetector(
                                            onTap: () {_displayTextInputDialog(context, data[0][types[index]][index1]);},
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image.asset("lib/assets/redmint.jpg",
                                                    width: 100.0, height: 30.0),
                                              ),
                                            ),
                                          )
                                      )],
                                  ),

                                  Row(
                                    children: [
                                      Text(
                                        "04/30/2021     \$800",//data[0]["credit"][index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),

                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child:
                                          GestureDetector(
                                            onTap: () {_displayTextInputDialog(context, data[0][types[index]][index1]);},
                                            child: Container(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20.0),
                                                child: Image.asset("lib/assets/redmint.jpg",
                                                    width: 100.0, height: 30.0),
                                              ),
                                            ),
                                          )
                                      )],
                                  ),






                                ],
                              )




                          );
                        }),
                    ElevatedButton(
                        onPressed: () {_displayTextInputDialog(context, "");},
                        child: Text('Add')),
                  ],
                )
            );
          },
        ),

        bottomNavigationBar: NavBar()

    );
  }





////////Transaction Screen -END/////


///// Transaction Modal/////

  TextEditingController _textFieldController = TextEditingController();

  String codeDialog = "";
  String valueText = "";

  Future<void> _displayTextInputDialog(BuildContext context, String changeText ) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(changeText == "" ? "Add" : "Edit"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = changeText == "" ? value : changeText;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: changeText),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  postData();
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}

//////// Transaction Modal - END /////
