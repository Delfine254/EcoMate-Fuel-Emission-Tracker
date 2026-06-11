import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.grey.shade100,
  body: Center(
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
  'Welcome Back',
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ),
),

SizedBox(height: 20),

Icon(
  Icons.local_gas_station,
  size: 80,
  color: Colors.blue,
),

SizedBox(height: 10),

Text(
  'EcoMate',
  style: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  ),
),

SizedBox(height: 30),
TextField(
  decoration: InputDecoration(
    labelText: 'Email',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
),

SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("Don't have an account?"),
    TextButton(
      onPressed: () {

      },
      child: Text(
        'Register',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),
          ],
        ),
      ),
    ),
  ),
);
  }
}