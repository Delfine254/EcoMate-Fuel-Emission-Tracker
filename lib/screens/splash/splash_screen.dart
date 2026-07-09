import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      },
    );
  }

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

          const Positioned(
            bottom: 50,
            left: 0,
            right: 0,

            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          ),

        ],
      ),
    );
  }
}