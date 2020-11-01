import 'package:flutter/material.dart';
import 'package:parking/forgetpass.dart';
import 'package:parking/screens/login_screen.dart';
import 'package:parking/screens/logo_screen.dart';
import 'package:parking/screens/map_screen.dart';
import 'package:parking/screens/registration_screen.dart';
import 'package:parking/screens/welcome_screen.dart';

void main() {
  runApp(Parking());
}

class Parking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      initialRoute: LoginScreen.id,
      initialRoute: ForgetScreen.id,
      routes: {
        LogoScreen.id: (context) => LogoScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        MapScreen.id: (context) => MapScreen(),
        ForgetScreen.id: (context) => ForgetScreen(),
      },
    );
  }
}
