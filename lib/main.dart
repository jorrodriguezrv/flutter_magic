import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_api_list/transactions.dart';
import 'package:local_auth/local_auth.dart';

void main() {

  runApp(new MaterialApp(
      home: MyApp()
  ));
}

/////// Login

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Red Mint Test',
      home: new LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _message = "Not Authorized";

  @override
  void initState() {
// TODO: implement initState
    checkingForBioMetrics();
    super.initState();
    _authenticateMe;
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: _buildBar(context),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
                image: AssetImage("lib/assets/redmint.jpg"), fit: BoxFit.cover),
          ),
          child: new Column(
            children: <Widget>[
              //  Image(image: AssetImage('lib/assets/redmint.jpg'),width: 50,height: 50,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildTextFields(),
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }


  PreferredSizeWidget _buildBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.red,
      title: new Text("Red-Mint"),
      centerTitle: true,
    );
  }


  Widget _buildTextFields() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: new InputDecoration(
                  labelText: 'Email'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              decoration: new InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return new Container(
      child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new ElevatedButton(
              child: new Text('Login'),
              onPressed: _authenticateMe,//_loginPressed,
              style: ElevatedButton.styleFrom(
                  primary: Colors.red, onPrimary: Colors.white),
            ),
          ),
          new TextButton(
            child: new Text('Dont have an account? Tap here to register.'),
            onPressed: () {},
          ),
          new TextButton(
            child: new Text('Forgot Password?'),
            onPressed: () {},
          )
        ],
      ),
    );
  }


  void _loginPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print("Biometrics ON $canCheckBiometrics");
    return canCheckBiometrics;
  }

  Future<void> _authenticateMe() async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Authenticate for Testing", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
      );
      setState(() {
        _message = authenticated ? "Authorized" : "Not Authorized";
      });
    } catch (e) {
      print(e);
    }
    print(_message);
   // if (!mounted) return;
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}
/////////// Login- END//////////
