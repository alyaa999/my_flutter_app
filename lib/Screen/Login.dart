import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/Screen/HomePage.dart';
import 'package:my_flutter_app/Screen/Register.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Sign In Page',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // API endpoint for authentication
  static const String authApiUrl =
      "https://localhost:7176/api/Account/Login"; // Replace with your actual API endpoint

  Future<void> _signIn() async {
    final String Username = UsernameController.text;
    final String password = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse(authApiUrl),
        body: jsonEncode({'Username': Username, 'Password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Authentication successful, extract and store the token
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final String token = responseData['token'];
        final String Username = responseData['username'];
        print(token);

        // Save the token for future authenticated requests (you can use a secure storage solution)
        // For simplicity, we're using shared preferences in this example
        // Replace this with a more secure storage solution in a production environment
        // Example using shared_preferences package:
        // await SharedPreferences.getInstance().then((prefs) => prefs.setString('token', token));

        // Navigate to the home page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(
              token: token,
              username: Username,
            ), // Pass the token to the home page
          ),
        );
      } else {
        // Handle authentication error, show a message or perform any other action
        print("Authentication failed: ${response.statusCode}");
        // Display an error message to the user using AlertDialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('${response.body} ,Please try again later.'),
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
    } catch (error) {
      // Handle network or other errors

      print("Error: $error");
    }
  }

  String selectedValue = 'Level1';
  String selectedValue2 = 'General';
  InputDecoration buildTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: const Color(0xffafd1e7)),
      ),
      filled: true,
      fillColor: Colors.white,
      alignLabelWithHint: true, // Align label with hint text
    );
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
              const SizedBox(height: 16),
              TextField(
                controller:
                    UsernameController, // Add this line to bind the controller

                decoration: buildTextFieldDecoration('Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller:
                    passwordController, // Add this line to bind the controller

                decoration: buildTextFieldDecoration('Password'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        _signIn();
                      },
                      child: const Text(
                        'Sign in',
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
                          builder: (context) =>
                              Register(), // Replace NextPage with your desired page
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t  have an account? Sign up Here',
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
