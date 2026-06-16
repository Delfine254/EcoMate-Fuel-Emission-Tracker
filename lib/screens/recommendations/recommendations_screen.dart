import 'package:flutter/material.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),

      body: Center(
        child: Text(
          'Recommendations Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}