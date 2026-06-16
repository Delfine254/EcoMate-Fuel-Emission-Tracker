import 'package:flutter/material.dart';

class PredictionsScreen extends StatelessWidget {
  const PredictionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions'),
      ),

      body: Center(
        child: Text(
          'Predictions Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}