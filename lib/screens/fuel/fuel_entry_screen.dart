import 'package:flutter/material.dart';

class FuelEntryScreen extends StatelessWidget {
  const FuelEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Entry'),
      ),

      body: Center(
        child: Text(
          'Fuel Entry Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}