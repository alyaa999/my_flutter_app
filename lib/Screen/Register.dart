import 'dart:convert'; // Import the dart:convert library for JSON encoding/decoding

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/Login.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sign In Page',
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String selectedValue = 'Level1';
  String selectedValue2 = 'General';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  InputDecoration buildTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xffafd1e7)),
      ),
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true,
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: buildTextFieldDecoration(label),
    );
  }

  Widget buildDropdown(String value, List<String> items, String label,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items: ['  ', ...items].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: buildTextFieldDecoration(label),
    );
  }

  Future<void> _register() async {
    try {
      final String apiUrl = "https://localhost:7176/api/Account/Register";
      int selectedValueLevel = 1;
      int selectedValueDepartment = 0;
      if (selectedValue == 'Level1') {
        selectedValueLevel = 1;
      } else if (selectedValue == 'Level2') {
        selectedValueLevel = 2;
      } else if (selectedValue == 'level3') {
        selectedValueLevel = 3;
      } else if (selectedValue == 'level4') {
        selectedValueLevel = 4;
      }

      if (selectedValue2 == 'General') {
        selectedValueDepartment = 1;
      } else if (selectedValue2 == 'Cs') {
        selectedValueDepartment = 2;
      } else if (selectedValue2 == 'It') {
        selectedValueDepartment = 3;
      }
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json'
        }, // Set the Content-Type header
        body: jsonEncode({
          'username': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'confirmPassword': confirmPasswordController.text,
          'level': selectedValueLevel.toString(),
          'department': selectedValueDepartment.toString(),
          'bio': '',
        }),
      );

      if (response.statusCode == 200) {
        // Registration successful, you may handle the response accordingly
        var responseData = json.decode(response.body);
        print('Registration successful: $responseData');
      } else {
        // Registration failed, handle the error
        print('Failed to register. Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (error) {
      print('Error during registration: $error');
    }
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
              const SizedBox(height: 35),
              buildTextField('Name', nameController),
              const SizedBox(height: 16),
              buildTextField('E-mail', emailController),
              const SizedBox(height: 16),
              buildTextField('Password', passwordController),
              const SizedBox(height: 16),
              buildTextField('Confirm Password', confirmPasswordController),
              const SizedBox(height: 15),
              buildDropdown(
                  selectedValue,
                  ['Level1', 'Level2', 'Level3', 'Level4'],
                  'Select your Level', (newValue) {
                if (newValue != null) {
                  setState(() {
                    if (newValue == 'Level1') {
                      selectedValue = newValue;
                    }
                  });
                }
              }),
              const SizedBox(height: 15),
              buildDropdown(selectedValue2, ['General', 'Cs', 'It'],
                  'Select your department', (newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedValue2 = newValue;
                  });
                }
              }),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        _register();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Home(
                              token: '',
                              username: nameController.text,
                            ), // Replace NextPage with your desired page
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
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
                          builder: (context) => Login(),
                        ),
                      );
                    },
                    child: const Text(
                      'I\'m already have an account! Sign in Here',
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
