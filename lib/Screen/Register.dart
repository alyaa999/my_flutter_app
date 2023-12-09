import 'package:flutter/material.dart';
import 'package:my_flutter_app/Screen/Login.dart';

void main() {
  runApp(Register());
}

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

  InputDecoration buildTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xffafd1e7)),
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
              const SizedBox(height: 35),
              TextField(
                decoration: buildTextFieldDecoration('Name'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: buildTextFieldDecoration('E-mail'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: buildTextFieldDecoration('Password'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: buildTextFieldDecoration('Confirm Password'),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedValue,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                },
                items: <String>['  ', 'Level1', 'Level2', 'Level3', 'Level4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: buildTextFieldDecoration('Select your Level'),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedValue2,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue2 = newValue;
                    });
                  }
                },
                items: <String>['    ', 'General', 'Cs', 'It']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: buildTextFieldDecoration('Select your department'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle Sign Up logic
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
