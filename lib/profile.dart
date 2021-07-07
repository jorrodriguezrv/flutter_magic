
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_api_list/Widget/info_card.dart';
import 'package:flutter_api_list/navBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_api_list/model/user.dart';
// our data
const url = "jorrodriguez@redventures.com";
const email = "jorrodriguez@redventures.com";
const phone = "787-529-8426"; // not real number :)
const location = "Santurce, PR";


class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  bool circular = false;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text("Red-Mint"),
          centerTitle: true,),
        body: SafeArea(
          minimum: const EdgeInsets.only(top: 20),
            child: new SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      imageProfile(),
                      Text(
                        "Jorge Rodriguez",
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),

                    InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
                    InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
                    InfoCard(
                        text: location,
                        icon: Icons.location_city,
                        onPressed: () async {}),
                    InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            ],
          ),),
        ),
        bottomNavigationBar: NavBar()
    );
  }




  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? FileImage(File("assets/profile.jpeg"))
              : FileImage(File(_imageFile!.path)),
        ),
        Positioned(
          bottom: 10.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.redAccent,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }



  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }


  void takePhoto(ImageSource source) async {
    print("Snap!");
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }





  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

//  Widget buildUpgradeButton() => ButtonWidget(
//    text: 'Upgrade To PRO',
//    onClicked: () {},
//  );

  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

}


