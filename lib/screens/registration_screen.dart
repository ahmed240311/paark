import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/screens/map_screen.dart';
import 'package:parking/screens/welcome_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final auth = FirebaseAuth.instance;
  String username;
  String email;
  String password;
  final _formKey=GlobalKey <FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character'),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email address is required'),
    EmailValidator(errorText: 'enter a valid email address '),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
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
                      height: 250.0,
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
                      'Username',
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
                    onChanged: (value) {
                      username = value;
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
                    validator: emailValidator,
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
                    validator: passwordValidator,
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
                    color: Colors.orange[600],
                    elevation: 4.0,
                    shadowColor: Colors.orange[400],
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          if ( _formKey.currentState.validate()){

//                              email != null &&
//                              email.isNotEmpty &&
//                              password != null &&

                            //registeration success
                            final newUser =
                                await auth.createUserWithEmailAndPassword(
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
                        'Register Now',
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
                    height: 65.0,
                  ),
                  Center(
                    child: Container(
                      width: 250.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ),
                          ),
                          FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Login',
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
