import 'package:flutter/material.dart';

class FuelHistoryScreen extends StatelessWidget {
  const FuelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel History'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: ListView(
          children: const [

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.local_gas_station,
                  color: Colors.blue,
                ),

                title: Text('Toyota Axio'),

            subtitle: Text(
  '20 L • 52,000 km\n2026-06-24\n\nEstimated CO₂: 46.2 kg',
),
              ),
            ),

            SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.local_gas_station,
                  color: Colors.green,
                ),

                title: Text('Nissan Note'),

                subtitle: Text(
  '15 L • 48,500 km\n2026-06-23\n\nEstimated CO₂: 34.7 kg',
),
              ),
            ),
          ],
        ),
      ),
    );
  }
}