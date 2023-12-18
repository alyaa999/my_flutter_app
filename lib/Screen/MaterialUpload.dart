import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/Profile.dart';

class Upload extends StatefulWidget {
  final String username;

  const Upload({Key? key, required this.username}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final TextEditingController textController1 = TextEditingController();
  final TextEditingController textController2 = TextEditingController();
  String _selectedItem = 'Operating System';
  List<String> _dropdownItems = [];

  String _selectedItem2 = 'Slides';
  List<CourseData> courses = [];
  late Future<void> _fetchCoursesFuture;

  @override
  void initState() {
    super.initState();
    _fetchCoursesFuture = _fetchAllCourses();
  }

  Future<void> _createMaterial() async {
    final String apiUrl =
        "https://zytoona.azurewebsites.net/api/Material/Create";
    String type = '';
    if (_selectedItem2 == 'Slides') {
      type = '0';
    } else if (_selectedItem2 == 'Notes') {
      type = '1';
    } else if (_selectedItem2 == 'Practice') {
      type = '2';
    } else if (_selectedItem2 == 'Past Exam') {
      type = '3';
    } else if (_selectedItem2 == 'Links') {
      type = '4';
    }
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'course': _selectedItem,
        'url': textController2.text,
        'type': type,
        'username': widget.username,
        'title': textController1.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Material created successfully');
    } else {
      final errorMessage = response.body ?? 'Unknown error';
      print('Failed to create material. Status code: ${response.statusCode}');
      print('Error message: $errorMessage');

      // Display an error message to the user using AlertDialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Material Creation Failed'),
            content: Text('$errorMessage, Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _fetchAllCourses() async {
    final String apiUrl =
        "https://localhost:7176/api/Course/GetAll"; // Replace with your actual API endpoint
    var token;
    final response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      final List<dynamic> coursesData = jsonDecode(response.body);
      setState(() {
        courses = coursesData.map((data) => CourseData.fromJson(data)).toList();
        _dropdownItems = courses.map((course) => course.title).toList();
      });
    } else {
      print("Failed to load courses: ${response.statusCode}");
    }
  }

  List<String> _dropdownItems2 = [
    'Slides',
    'Notes',
    'Practice',
    'Past Exam',
    'Links',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("File your Material"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
            future: _fetchCoursesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading courses'));
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.upload_file,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: textController1,
                      labelText: 'Title',
                      hintText: 'Please enter the title',
                      prefixIcon: Icons.text_fields,
                    ),
                    SizedBox(height: 20),
                    _buildTextField(
                      controller: textController2,
                      labelText: 'URL',
                      hintText: 'Please enter the URL of the material',
                      prefixIcon: Icons.link,
                    ),
                    SizedBox(height: 20),
                    _buildDropdown(
                      label: 'Select a type of material',
                      value: _selectedItem2,
                      items: _dropdownItems2,
                      onChanged: (String? selectedItem) {
                        setState(() {
                          _selectedItem2 = selectedItem!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    _buildDropdown(
                      label: 'Select a course',
                      value: _selectedItem,
                      items: _dropdownItems,
                      onChanged: (String? selectedItem) {
                        setState(() {
                          _selectedItem = selectedItem!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        onPressed:
                        _createMaterial();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(studentUsername: widget.username),
                          ),
                        );

                        String textFieldValue1 = textController1.text;
                        String textFieldValue2 = textController2.text;
                        print('Text Field 1: $textFieldValue1');
                        print('Text Field 2: $textFieldValue2');
                        print('Selected Option 1: $_selectedItem');
                        print('Selected Option 2: $_selectedItem2');
                      },
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Home(
                              username: widget.username,
                              token: '',
                            ),
                          ),
                        );
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: Icon(Icons.check_circle),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 8),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(item),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: TextStyle(color: Colors.black, fontSize: 16),
          icon: Icon(Icons.arrow_drop_down),
          isExpanded: true,
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class CourseData {
  final int id;
  final String title;
  final String courseCode;
  final String? image;

  CourseData({
    required this.id,
    required this.title,
    required this.courseCode,
    this.image,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'],
      title: json['title'],
      courseCode: json['courseCode'],
      image: json['image'],
    );
  }
}
