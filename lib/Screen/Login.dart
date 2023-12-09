import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/Register.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sign In Page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedValue = 'Level1';
  String selectedValue2 = 'General';
  InputDecoration buildTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: const Color(0xffafd1e7)),
      ),
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true, // Align label with hint text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 163, 250, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This is the page to sign in to your account',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: buildTextFieldDecoration('E-mail'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: buildTextFieldDecoration('Password'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the main screen when the user logs in
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff0479db),
                        onPrimary: Colors.white,
                        elevation: 5,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              Register(), // Replace NextPage with your desired page
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t  have an account? Sign up Here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
