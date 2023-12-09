import 'package:flutter/material.dart';

void main() {
  runApp(const Course());
}

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _Coursestate();
}

class _Coursestate extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: const Text("course"),
      )),
    );
  }
}
