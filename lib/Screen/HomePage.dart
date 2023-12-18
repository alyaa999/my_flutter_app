import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/Screen/Course.dart';
import 'package:my_flutter_app/Screen/MaterialUpload.dart';
import 'package:my_flutter_app/Screen/Profile.dart';

class Home extends StatefulWidget {
  final String token;

  final String username;

  const Home(
      {required this.token,
      required this.username, // Add this line to receive the username
      Key? key})
      : super(key: key);

  @override
  State<Home> createState() => _Homestate(token: token, username: username);
}

class _Homestate extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();

  final String token;

  final String username;

  _Homestate({required this.token, required this.username});

  List<CourseData> courses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 8,
      vsync: this,
    );
    _fetchAllCourses();
  }

  Future<void> _fetchAllCourses() async {
    final String apiUrl =
        "https://zytoona.azurewebsites.net/api/Course/GetAll"; // Replace with your actual API endpoint
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> coursesData = jsonDecode(response.body);
      setState(() {
        courses = coursesData.map((data) => CourseData.fromJson(data)).toList();
      });
    } else {
      print("Failed to load courses: ${response.statusCode}");
    }
  }

  Future<void> _fetchCoursesByDepartment(int department) async {
    try {
      final String apiUrl =
          "https://zytoona.azurewebsites.net/api/Course/FilterByDeptarment?department=$department";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesData = jsonDecode(response.body);
        setState(() {
          courses =
              coursesData.map((data) => CourseData.fromJson(data)).toList();
        });
      } else {
        print("Failed to load courses by department: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching courses by department: $error");
    }
  }

  Future<void> _fetchCoursesByLevel(int level) async {
    try {
      final String apiUrl =
          "https://zytoona.azurewebsites.net/api/Course/FilterByLevel?level=$level";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesData = jsonDecode(response.body);
        setState(() {
          courses =
              coursesData.map((data) => CourseData.fromJson(data)).toList();
        });
      } else {
        print("Failed to load courses by department: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching courses by department: $error");
    }
  }

  Future<void> _searchCourses(String searchTerm) async {
    try {
      final String apiUrl =
          "https://zytoona.azurewebsites.net/api/Course/Search?title=$searchTerm";
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesData = jsonDecode(response.body);
        setState(() {
          courses =
              coursesData.map((data) => CourseData.fromJson(data)).toList();
        });
      } else {
        print("Failed to load courses by search: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching courses by search: $error");
    }
  }

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 0.0,
                    child: ListTile(
                      title: Text("Good morning,"),
                      subtitle: Text(
                        username, // Set username
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      iconColor: Colors.blue,
                      trailing: Icon(
                        Icons.person,
                        size: 30,
                      ),
                    ),
                  )),
              Container(
                height: 45,
                width: 350,
                child: TextField(
                  controller:
                      _searchController, // Assign the controller to the TextField

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    hintText: "search",
                    suffixIcon: Icon(Icons.search_outlined),
                  ),
                  onSubmitted: (String searchTerm) {
                    // Call the search API when Enter is pressed
                    _searchCourses(searchTerm);
                  },
                ),
              ),
              Container(
                height: 10,
              ),
              TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                automaticIndicatorColorAdjustment: true,
                controller: _tabController,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'General'),
                  Tab(text: 'Computer Science'),
                  Tab(text: 'Information Technology'),
                  Tab(text: 'Level 1'),
                  Tab(text: 'Level 2'),
                  Tab(text: 'Level 3'),
                  Tab(text: 'Level 4'),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      _fetchAllCourses(); // Fetch all courses
                      break;
                    case 1:
                      _fetchCoursesByDepartment(1);
                      break;
                    case 2:
                      _fetchCoursesByDepartment(2);
                      break;
                    case 3:
                      _fetchCoursesByDepartment(3);
                      break;
                    case 4:
                      _fetchCoursesByLevel(1);
                      break;
                    case 5:
                      _fetchCoursesByLevel(2);
                      break;
                    case 6:
                      _fetchCoursesByLevel(3);
                      break;
                    case 7:
                      _fetchCoursesByLevel(4);
                      break;
                  }
                },
              ),
              Container(
                height: 25,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
// Inside your GridView.builder
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              2, // Set the cross-axis count to 3 for three items in each row
                          crossAxisSpacing:
                              10, // Adjust the spacing between items horizontally
                          mainAxisSpacing:
                              10, // Adjust the spacing between items vertically
                          mainAxisExtent:
                              200, // Set the main axis extent to control the height of each item
                        ),
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigate to the course details page on tap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Course(
                                    Id: courses[index].id,
                                    username: username,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4.0,
                              child: Column(
                                children: [
                                  Container(
                                    width: double
                                        .infinity, // Make the image take the full width
                                    height:
                                        100, // Set a fixed height for the image
                                    child: Image.asset(
                                      courses[index].image ??
                                          'assets/images/XDP.jpeg',
                                      fit: BoxFit
                                          .cover, // Ensure the image covers the entire container
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        // Provide a default/fallback image in case of an error
                                        return Image.asset(
                                          'assets/images/XDP.jpeg',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Add some spacing between the image and text
                                  Text(
                                    courses[index].title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          4), // Add some spacing between the title and description
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      courses[index].courseCode,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign
                                          .center, // Center the description text
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BottomNavigationBar(
                onTap: _onTabTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Home(username: username, token: ''),
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
                              studentUsername: username,
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
                                  Upload(username: username)));
                        },
                        icon: const Icon(Icons.upload)),
                    label: 'Upload File',
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
