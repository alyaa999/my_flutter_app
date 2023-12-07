import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/Login.dart';
import 'package:my_flutter_app/Screen/SignUp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(), // write the page you work on it to test ..
      routes: {
        '/login': (context) => Login(),
        '/homepage': (context) => HomePage(
              token: '',
            ),
        '/signUp': (context) => Signup(),
      },
    );
  }
}
