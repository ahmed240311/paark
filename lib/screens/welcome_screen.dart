
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parking/main.dart';
import 'package:parking/screens/login_screen.dart';
import 'package:parking/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<Color> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 1 ),
        vsync: this
    );
    animation =
        ColorTween(begin: Colors.orange[600], end: Colors.white).animate(
            controller);
    controller.addListener(() {
      setState(() {});
   });
  }
  bool buttonToggle = true;

  void animateColor() {
    if (buttonToggle) {
      controller.forward();
    } else {
      controller.reverse();
    }
    buttonToggle = !buttonToggle;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[600],
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 220.0, left: 13.0, right: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      onPressed: () {
//                        if(controller.status == AnimationStatus.completed){
//                          controller.reverse();
//                        }else{
//                          controller.forward();
//                        }
                        animateColor();
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      borderSide: BorderSide(color: Colors.white,
                          style: BorderStyle.solid,
                          width: 2.0),
                      textTheme: ButtonTextTheme.normal,
                      //hoverColor: Colors.white,
                      color: animation.value,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: double.infinity,
                    ),
                    OutlineButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        });
                      },
                      borderSide: BorderSide(
                          color: Colors.white, style: BorderStyle.solid , width: 2.0),
                      textTheme: ButtonTextTheme.normal,
                      hoverColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
                        child: Text(
                          'Register Now',
                          style: TextStyle(color: Colors.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
@override
  void dispose() {
  controller.dispose();
    super.dispose();
  }
}
