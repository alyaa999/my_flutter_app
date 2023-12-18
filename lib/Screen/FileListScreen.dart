import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/MaterialUpload.dart';
import 'package:my_flutter_app/Screen/Profile.dart';
import 'package:url_launcher/url_launcher.dart';

class FileListScreen extends StatefulWidget {
  final int courseId;
  final int type;
  final String username;

  FileListScreen({
    required this.courseId,
    required this.type,
    required this.username,
  });

  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  List<FileItemData> fileItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch material types when the widget is initialized
    _fetchMaterialTypes();
  }

  Future<void> _fetchMaterialTypes() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://zytoona.azurewebsites.net/api/Material/ViewSpecificMaterialsType?courseId=${widget.courseId}&type=${widget.type}",
        ),
        // Replace "https://your-api-url" with the actual URL of your API
      );

      if (response.statusCode == 200) {
        // Parse the response JSON
        final List<dynamic> materialTypesData = jsonDecode(response.body);

        // Update the state with material types
        setState(() {
          fileItems = materialTypesData
              .map((data) => FileItemData.fromJson(data))
              .toList();
        });
      } else {
        // Handle error cases
        print("Failed to fetch material types: ${response.statusCode}");
      }
    } catch (error) {
      // Handle network or other errors
      print("Error fetching material types: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Types'),
      ),
      body: ListView.builder(
        itemCount: fileItems.length,
        itemBuilder: (context, index) {
          final FileItemData fileItem = fileItems[index];
          return FileItem(
            name: fileItem.title,
            time: fileItem.username,
            url: fileItem.url,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      Home(username: widget.username, token: ''),
                ));
              },
              icon: const Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(studentUsername: widget.username),
                ));
              },
              icon: const Icon(Icons.person_outline),
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Upload(username: widget.username),
                ));
              },
              icon: const Icon(Icons.upload_file),
            ),
            label: 'Upload File',
          ),
        ],
      ),
    );
  }

  // Function to handle BottomNavigationBar item taps
  void _onTabTapped(int index) {
    // You can implement specific actions for each tab if needed
    print('Tab $index tapped');
  }
}

class FileItemData {
  final String title;
  final String url;
  final String username;

  FileItemData({
    required this.title,
    required this.url,
    required this.username,
  });

  factory FileItemData.fromJson(Map<String, dynamic> json) {
    return FileItemData(
      title: json['title'],
      url: json['url'],
      username: json['username'],
    );
  }
}

class FileItem extends StatelessWidget {
  final String name;
  final String time;
  final String url;

  const FileItem({
    Key? key,
    required this.name,
    required this.time,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ListTile(
        leading: Icon(Icons.insert_drive_file, color: Colors.blue),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(time),
        trailing: IconButton(
          icon: Icon(Icons.open_in_browser),
          onPressed: () {
            _launchURL(url);
          },
        ),
      ),
    );
  }

  // Function to launch the URL
  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        // Handle error if the URL can't be launched
        print('Could not launch $url');
      }
    } catch (e) {
      // Print any exception that occurs during launching
      print('Error launching URL: $e');
    }
  }
}
