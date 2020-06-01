import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'RegistrationPage.dart';
import 'BottomNavigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompeteIT',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: LoginPage(),
      //initialRoute: '/',
      //routes: {
        //'/': (context) => LoginPage(),
        //'/registration': (context) => FirstRegistrationPage(),
        //'/mainPage': (context) => BottomNavigation(),
      //},
    );
  }
}

