import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Course {
  int? levelId;
  int? departmentId;
  String description;
  String title;
  String courseCode;
  String image;
  int id;

  Course({
    this.levelId,
    this.departmentId,
    required this.description,
    required this.title,
    required this.courseCode,
    required this.image,
    required this.id,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      levelId: json['level'],
      departmentId: json['department'],
      description: json['description'],
      title: json['title'],
      courseCode: json['courseCode'],
      image: json['image'],
      id: json['id'],
    );
  }
}

class Material {
  int id;
  int type;
  String description;
  String path;
  int courseId;
  int studentId;

  Material({
    required this.id,
    required this.type,
    required this.path,
    required this.description,
    required this.courseId,
    required this.studentId,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      path: json['path'],
      courseId: json['courseId'],
      studentId: json['studentId'],
    );
  }
}

class Student {
  String username;
  int? level;
  int department;
  String? bio;
  List<Course> courses;
  List<Material> material;
  int FavCount;
  int uploadCount;

  Student({
    required this.username,
    this.level,
    required this.department,
    required this.bio,
    required this.courses,
    required this.material,
    required this.FavCount,
    required this.uploadCount,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      username: json['username'],
      level: json['level'],
      department: json['department'],
      bio: json['bio'],
      courses: (json['courses'] as List<dynamic>?)
              ?.map((courseJson) => Course.fromJson(courseJson))
              .toList() ??
          [],
      material: (json['materials'] as List<dynamic>?)
              ?.map((materialJson) => Material.fromJson(materialJson))
              .toList() ??
          [],
      FavCount: json['favCount'],
      uploadCount: json['uploadCount'],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                course.image,
                width: 60.0,
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Code: ${course.courseCode}'),
                  Text(course.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String apiUrl =
      'https://localhost:7176/api/Student/ViewProfile?username'; // Replace with your API endpoint
  final String studentUsername;

  ProfilePage({required this.studentUsername});

  Future<Student> _fetchStudent() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl=$studentUsername'));

      if (response.statusCode == 200) {
        return Student.fromJson(json.decode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to propagate it to FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _fetchStudent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the Future to complete
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Show an error message if the Future fails
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // The Future is complete, and we have the student data
            Student _student = snapshot.data as Student;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                      height: 266,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset(
                            'assets/images/XDP.jpeg',
                            fit: BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Positioned(
                            left: 16.0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _student.username,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Level: ${_student.level}'),
                            SizedBox(height: 8.0),
                            Text('Department: ${_student.department}'),
                          ],
                        ),
                        SizedBox(width: 90.0),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle edit profile action
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.0),
                      child: Container(
                        color: Color(0xfff9f7f7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bio:',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('${_student.bio}'),
                            SizedBox(height: 16.0),
                            Text(
                              'Added Courses:',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              children: _student.courses
                                      .map((course) =>
                                          CourseCard(course: course))
                                      .toList() ??
                                  [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
