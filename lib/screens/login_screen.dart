
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/screens/map_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GoogleSignInAccount _currentUser;
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

//  @override
//  void initState() {
//    super.initState();
//    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//      setState(() {
//        _currentUser = account;
//      });
//      if (_currentUser != null) {
//
////        _handleGetContact();
//      }
//    });
//    _googleSignIn.signInSilently();
//  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn().whenComplete(() =>
          Navigator.pushNamed(context, MapScreen.id));
    } catch (error) {
      print(error);
    }
  }
//   LoginValidation(String email , String password) async{
//    final Map<String , dynamic> authData= {
//    'email' : email,
//    'password' : password,
//      'returnSecureToken' : true
//    };
//    final http.Response response =
//    await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyC3Tbplth1F56eft9WALgyVWnyos-SZGCc',
//    body: json.encode(authData),
//       headers: {'Content-Type' : 'application/json'}
//    );
//    final Map<String , dynamic> responseData = json.decode(response.body);
//    bool hasError = true;
//    String message = 'Something Went Wrong';
//    //print(responseData);
//    if(responseData.containsKey('idToken')){
//      hasError=false;
//      message = 'authentication succeeded !';
//    }else if(responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
//      message = 'incorrect email';
//    }else if(responseData['error']['message'] == 'INVALID_PASSWORD'){
//      message = 'incorrect password';
//    }
//    }
//   emailValidation(String email ) async{
//    final Map<String , dynamic> authData= {
//      'email' : email,
//      //'password' : password,
//      'returnSecureToken' : true
//    };
//    final http.Response response =
//    await http.post('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key= AIzaSyC3Tbplth1F56eft9WALgyVWnyos-SZGCc',
//        body: json.encode(authData),
//        headers: {'Content-Type' : 'application/json'}
//    );
//    final Map<String , dynamic> responseData = json.decode(response.body);
//    bool hasError = true;
//    //String message = 'Something Went Wrong';
//    //print(responseData);
////    if(responseData.containsKey('idToken')){
////      hasError=false;
////      return 'authentication succeeded !';
////    }
//    if(responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
//      return 'incorrect email';
//    }
////    }else if(responseData['error']['message'] == 'INVALID_PASSWORD'){
////      message = 'incorrect password';
////    }
//
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 200.0,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 50.0, top: 90.0),
                        child: Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              child: Image.asset('images/car.png'),
                              radius: 40.0,
                              backgroundColor: Colors.orange[400],
                            ),
                            Text('Er Kenly',
                                style: GoogleFonts.caveat(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w900))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  TextFormField(
                    autocorrect: true,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.orange[600],
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.black,
                        height: 0.3),
                       decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          //borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 18.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    autocorrect: true,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.orange[600],
                    onChanged: (value) {
                      password = value;
                    },
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0,
                        color: Colors.black,
                        height: 0.3),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          //borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Colors.grey[300]),
                        )),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 24.0,
                  ),
                  Material(
                    // borderRadius: BorderRadius.circular(18.0),
                    color: Colors.orange[600],
                    elevation: 4.0,
                    shadowColor: Colors.orange[400],
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          if ( _formKey.currentState.validate()) {

//                                email != null &&
//                              email.isNotEmpty &&
//                              password != null &&
//                              password.isNotEmpty

                            final user = await auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            Navigator.pushNamed(context, MapScreen.id);
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      height: 30,
                      minWidth: double.infinity,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 1.0,
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 12.0,
                  ),
                  Center(
                    child: Container(
                      width: 270.0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                                color: Colors.grey[800],
                              )),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'or',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                              child: Divider(
                                color: Colors.grey[800],
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 24.0,
                  ),
                  Material(
                    // borderRadius: BorderRadius.circular(18.0),
                    color: Colors.blue[900],
                    elevation: 3.0,
                    shadowColor: Colors.blue[500],
                    child: MaterialButton(
                      onPressed: _handleSignIn,
                      height: 40,
                      minWidth: double.infinity,
                      child:Row(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 30.0,left: 20.0)),

                          Image.asset("images/google_logo.png",width: 17.0,),
                          Padding(padding: EdgeInsets.only(right: 25.0)),
                          Text(
                            'SignIn With Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      )


                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 65.0,
                  ),
                  Center(
                    child: Container(
                      width: 250.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'dont have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.orange[600],
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
