import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/MaterialUpload.dart';
import 'package:my_flutter_app/Screen/course.dart';

class CourseDetails {
  int? levelId;
  int? departmentId;
  String description;
  String title;
  String courseCode;
  String image;
  int id;

  CourseDetails({
    this.levelId,
    this.departmentId,
    required this.description,
    required this.title,
    required this.courseCode,
    required this.image,
    required this.id,
  });

  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    return CourseDetails(
      levelId: json['levelId'],
      departmentId: json['departmentId'],
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
  DateTime date;

  Material({
    required this.id,
    required this.type,
    required this.path,
    required this.description,
    required this.courseId,
    required this.studentId,
    required this.date,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['id'],
      type: json['type'],
      description: json['description'],
      path: json['path'],
      courseId: json['courseId'],
      studentId: json['studentId'],
      date: DateTime.parse(json['date']),
    );
  }
}

class Student {
  String username;
  int? level;
  int department;
  String? bio;
  List<CourseDetails> courses;
  List<Material> material;
  int FavCount;
  int uploadCount;
  String email;

  Student({
    required this.username,
    this.level,
    required this.department,
    required this.bio,
    required this.courses,
    required this.material,
    required this.FavCount,
    required this.uploadCount,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      username: json['username'],
      level: json['level'],
      department: json['department'],
      bio: json['bio'],
      courses: (json['courses'] as List<dynamic>?)
              ?.map((courseJson) => CourseDetails.fromJson(courseJson))
              .toList() ??
          [],
      material: (json['materials'] as List<dynamic>?)
              ?.map((materialJson) => Material.fromJson(materialJson))
              .toList() ??
          [],
      FavCount: json['favCount'],
      uploadCount: json['uploadCount'],
      email: json['email'],
    );
  }
}

class CourseCard extends StatelessWidget {
  final CourseDetails course;
  final String username;
  CourseCard({required this.course, required this.username});

  @override
  Widget build(BuildContext context) {
    String department = "";
    if (course.departmentId == 1) {
      department = "General";
    } else if (course.departmentId == 2) {
      department = "Computer Science";
    } else if (course.departmentId == 3) {
      department = "Information Technology";
    }
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.grey[200],
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => Course(
                      Id: course.id,
                      username: username,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Hero(
                tag: course.image, // Unique tag for Hero animation
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    course.image,
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0, // Adjust font size as needed
                      ),
                    ),
                    Text(
                      'Code: ${course.courseCode}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      department,
                      maxLines: 2, // Limit description to 2 lines
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
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

class ProfilePage extends StatelessWidget {
  final String apiUrl =
      'https://zytoona.azurewebsites.net/api/Student/ViewProfile?username'; // Replace with your API endpoint
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Student _student = snapshot.data as Student;
            String ans = '';
            if (_student.department == 1)
              ans = 'Genaral';
            else if (_student.department == 2)
              ans = 'Computer Science';
            else if (_student.department == 3) ans = 'Information';

            var _onTabTapped;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  _buildProfileImage(),
                  SizedBox(height: 20.0),
                  Text(
                    _student.username,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ans,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _buildProfileDetailsCard(_student),
                  SizedBox(height: 20.0),
                  _buildFavoriteCourses(_student),
                  _buildUploadedMaterials(_student),
                  BottomNavigationBar(
                    onTap: _onTabTapped,
                    items: [
                      BottomNavigationBarItem(
                        icon: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Home(username: studentUsername, token: ''),
                              ));
                            },
                            icon: const Icon(Icons.home)),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage(
                                  studentUsername: studentUsername,
                                ),
                              ));
                            },
                            icon: const Icon(Icons.person_outline)),
                        label: 'Profile',
                      ),
                      BottomNavigationBarItem(
                        icon: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Upload(username: studentUsername),
                              ));
                            },
                            icon: const Icon(Icons.upload_file)),
                        label: 'Upload File',
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue,
          width: 3.0,
        ),
      ),
      child: CircleAvatar(
        radius: 80.0,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
    );
  }

  Widget _buildProfileDetailsCard(Student student) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileSection(
                'E-mail', student.email ?? 'No email available'),
            _buildProfileSection('Bio', student.bio ?? 'SoftWare Engineer'),
            _buildProfileSection(
                'Level',
                student.level.toString() == 'null'
                    ? 'Level 4'
                    : student.level.toString()),

            // Add more profile sections as needed
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCourses(Student student) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Favorite Courses',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(142, 3, 95, 170),
              ),
            ),
            SizedBox(height: 8.0),
            if (student.courses != null && student.courses.isNotEmpty)
              Column(
                children: student.courses
                    .map((course) => CourseCard(
                          course: course,
                          username: studentUsername,
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedMaterials(Student student) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Uploaded Materials',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(142, 3, 95, 170),
              ),
            ),
            SizedBox(height: 8.0),
            if (student.material != null && student.material.isNotEmpty)
              Column(
                children: List.generate(
                  student.material.length,
                  (index) {
                    final material = student.material[index];
                    return _buildMaterialCard(material);
                  },
                ),
              ),
            if (student.material == null || student.material.isEmpty)
              Text(
                'No uploaded materials available.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialCard(Material material) {
    IconData iconData;
    Color iconColor;

    // Determine the icon and color based on the material type
    switch (material.type) {
      case 0:
        // Document
        iconData = Icons.slideshow;
        iconColor = Colors.blue;
        break;
      case 1:
        // Video
        iconData = Icons.notes; // Corrected video icon
        iconColor = Colors.orange; // Different color for video
        break;
      case 2:
        iconData = Icons.assignment;
        iconColor = Colors.green; // Different color for assignment
        break;
      case 3:
        iconData = Icons.book;
        iconColor = Colors.purple; // Different color for book
        break;
      case 4:
        iconData = Icons.link;
        iconColor = Colors.indigo; // Different color for link
        break;
      default:
        iconData = Icons.link;
        iconColor = Colors.indigo;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.0),
        title: Text(
          material.description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type: ${_getMaterialTypeText(material.type)}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Text(
              ' ${_getFormattedDate(material.date)}', // Display the formatted date
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
        leading: Icon(
          iconData,
          color: iconColor,
        ),
        onTap: () {
          // Add navigation or any action when the material is tapped
        },
      ),
    );
  }

  String _getMaterialTypeText(int type) {
    switch (type) {
      case 0:
        return 'Slideshow';
      case 1:
        return 'Notes';
      case 2:
        return 'Assignment';
      case 3:
        return 'PastExam';
      case 4:
        return 'Link';
      default:
        return 'Unknown';
    }
  }

  String _getFormattedDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy')
        .format(date); // Use DateFormat to format the date
  }
}
