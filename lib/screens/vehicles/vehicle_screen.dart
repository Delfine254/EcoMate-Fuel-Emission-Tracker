import 'package:flutter/material.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Management'),
      ),

      body: Center(
        child: Text(
          'Vehicle Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}