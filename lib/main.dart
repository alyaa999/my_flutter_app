import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/Login.dart';
import 'package:my_flutter_app/Screen/Register.dart';
import 'package:my_flutter_app/Screen/SignUp.dart';
import 'package:my_flutter_app/Screen/Welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Center Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Signin(),
      routes: {
        '/login': (context) => Login(),
        '/homepage': (context) => Home(),
        '/Register': (context) => Register(),
      },
    );
  }
}

class ImageCenterPage extends StatefulWidget {
  @override
  _ImageCenterPageState createState() => _ImageCenterPageState();
}

class _ImageCenterPageState extends State<ImageCenterPage> {
  @override
  void initState() {
    super.initState();

    // Add a delay to display the page for 3 seconds (adjust as needed)
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to another page after the delay
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              Welcome(), // Replace NextPage with your desired page
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(83, 163, 250, 1),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 48),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromRGBO(83, 163, 250, 1),
                ),
                child: Center(
                  child: Image.asset(
                    'images/StudyTeach2 1.png',
                    width: 362,
                    height: 257,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Your content for the next page
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('This is the next page.'),
      ),
    );
  }
}
