import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Stack(

        children: [

          Center(
            child: Image.asset(
              'assets/images/splash.png',
              width: 330,
            ),
          ),

Positioned(
    bottom: 120,
    left: 0,
    right: 0,
    child: Center(
      child: Text(
        'Track Fuel. Reduce Emissions.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.green,
          letterSpacing: 0.5,
        ),
      ),
    ),
  ),
  
          Positioned(
  bottom: 50,
  left: 40,
  right: 40,
  child: SizedBox(
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
      child: const Text(
        'Continue',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

        ],
      ),
    );
  }
}