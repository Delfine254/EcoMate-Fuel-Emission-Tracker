import 'package:flutter/material.dart';

class EmissionsScreen extends StatelessWidget {
  const EmissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emissions'),
      ),

      body: Center(
        child: Text(
          'Emissions Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}