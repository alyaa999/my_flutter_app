import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/MaterialUpload.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Course extends StatefulWidget {
  Course({Key? key, required this.Id}) : super(key: key);

  final int Id;

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  late CourseData course = CourseData(
    id: 0,
    title: '',
    courseCode: '',
    description: '',
  );
  late MaterialData materialCount = MaterialData(
    slides: 0,
    notes: 0,
    practice: 0,
    pastExam: 0,
    links: 0,
  );
  @override
  void initState() {
    super.initState();
    _fetchCoursesById(widget.Id as int);
    _fetchMaterialsNumbers(widget.Id as int);
  }

  Future<void> _fetchCoursesById(int id) async {
    try {
      final String apiUrl = "https://localhost:7176/api/Course/Get?id=$id";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer YOUR_TOKEN_HERE'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> courseData = jsonDecode(response.body);

        setState(() {
          course = CourseData.fromJson(courseData);
        });
      } else {
        print("Failed to load course by id: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching course by id: $error");
    }
  }

  Future<void> _fetchMaterialsNumbers(int id) async {
    try {
      final String apiUrl =
          "https://localhost:7176/api/Course/CountMaterialOfCourse?id=$id";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer YOUR_TOKEN_HERE'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> materialData = jsonDecode(response.body);

        setState(() {
          materialCount = MaterialData.fromJson(materialData);
        });
      } else {
        print("Failed to load course by id: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching course by id: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title), // change to title of course..
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Container(
                    width: double.infinity,
                    height: 200.0, // Set the desired height
                    padding:
                        EdgeInsets.all(10.0), // Adjust the padding as needed
                    child: Image.asset(
                      course.image ?? 'assets/images/XDP.jpeg',
                      fit: BoxFit.cover,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(left: 10.0, top: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.courseCode,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      course.title,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors
                                .transparent, // Set the desired background color

                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Dr. nadnooda'),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                        course.description ?? 'No description available',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Container(
                        width: 300.0, // Set the desired width,
                        margin: EdgeInsets.only(bottom: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Center(
                              child: Row(
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 10),
                                  Text('Enroll To The Course'),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.symmetric(
                    horizontal: 20), // Added padding for the entire body
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Slides',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialUpload()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/sticky-note.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class Notes/Slides',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.grey,
                                      ), // Your icon
                                      SizedBox(width: 5),
                                      Text(
                                        materialCount.slides.toString() +
                                            ' Files',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialUpload()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/edit.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class Notes/Slides',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.grey,
                                      ), // Your icon
                                      SizedBox(width: 5),
                                      Text(
                                        materialCount.notes.toString() +
                                            ' Files',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Practice/Assignments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialUpload()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/books.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class Notes/Slides',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.grey,
                                      ), // Your icon
                                      SizedBox(width: 5),
                                      Text(
                                        materialCount.practice.toString() +
                                            ' Files',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Past Exams',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialUpload()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/file.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class Notes/Slides',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.grey,
                                      ), // Your icon
                                      SizedBox(width: 5),
                                      Text(
                                        materialCount.pastExam.toString() +
                                            ' Files',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Video Links',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaterialUpload()),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/images/glasses.png',
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Class Notes/Slides',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.link,
                                        color: Colors.grey,
                                      ), // Your icon
                                      SizedBox(width: 5),
                                      Text(
                                        materialCount.pastExam.toString() +
                                            ' Links',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseData {
  final int id;
  final String title;
  final String courseCode;
  final String? image;
  final String? description;

  CourseData({
    required this.id,
    required this.title,
    required this.courseCode,
    this.image,
    this.description,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'],
      title: json['title'],
      courseCode: json['courseCode'],
      image: json['image'],
      description: json['description'],
    );
  }
}

class MaterialData {
  final int slides;
  final int notes;
  final int practice;
  final int pastExam;
  final int links;

  MaterialData({
    required this.slides,
    required this.notes,
    required this.practice,
    required this.pastExam,
    required this.links,
  });

  factory MaterialData.fromJson(Map<String, dynamic> json) {
    return MaterialData(
      slides: json['slides'],
      notes: json['notes'],
      practice: json['practice'],
      pastExam: json['pastExam'],
      links: json['links'],
    );
  }
}
