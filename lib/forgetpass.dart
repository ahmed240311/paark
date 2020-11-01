import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  static const String id = 'forget';

  @override
  _forgetpass createState() => _forgetpass();
}

class _forgetpass extends State<ForgetScreen> {
  final _text = TextEditingController();
  bool _validate = false;
  String _emailController = "";
  final _formkey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    ' we happy to serve you ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ],
              )),
              SizedBox(
                height: 50.0,
              ),
              Container(
//            margin: EdgeInsets.only( left: 200.0),
//                  margin: EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.only(left: 22.0),

                child: TextField(
                  controller: _text,
                  decoration: InputDecoration(
                    labelText: 'please enter your email',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  onChanged: (val) => _emailController = val,
                ),
              ),
              Divider(
                height: 5.0,
                thickness: 1.0,
                color: Colors.teal.shade900.withOpacity(1.0),
                indent: 32,
                endIndent: 32,
              ),
              SizedBox(
                height: 80.0,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    _text.text.isEmpty ? _validate = true

                        : _validate = false;
//                    showAlertDialog(context);


                  });

                  if (_formkey.currentState.validate()) {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController)
                        .then((val) => print("check your mail"));
                  }


                },
                child: Text(
                  "submit ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black26)),
                color: Colors.orange[600],
              ),

            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("Already sent a message to your email."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
