import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/Login.dart';
import 'package:my_flutter_app/Screen/Register.dart';

void main() {
  runApp(const Welcome());
}

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Center Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ImageCenterPage(),
    );
  }
}

class ImageCenterPage extends StatelessWidget {
  const ImageCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(83, 163, 250, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Are you ready to learn?',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),
              Container(
                width: 250, // Set the width of the container
                height: 250, // Set the height of the container
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromRGBO(83, 163, 250, 1),
                ),
                child: Center(
                  child: Image.asset(
                    'images/317.jpg', // Replace with the path to your image asset
                    width: 362, // Set the width of the image
                    height: 257, // Set the height of the image
                  ),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          Login(), // Replace NextPage with your desired page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffffffff),
                  onPrimary: const Color(0xff178ce0),
                  padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          Register(), // Replace NextPage with your desired page
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(0, 109, 238, 1),
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
