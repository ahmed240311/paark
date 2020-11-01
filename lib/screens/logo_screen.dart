import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking/screens/welcome_screen.dart';
import 'dart:async';


class LogoScreen extends StatefulWidget {
  static const String id = 'logo_screen';

  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen())));

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: TyperAnimatedTextKit(
            text: ['Er', 'Kenly'],
            textStyle: TextStyle(
                fontSize: 30.0, fontFamily: 'Bobbers', color: Colors.white),

//            },
          ),
        ));
  }
}
