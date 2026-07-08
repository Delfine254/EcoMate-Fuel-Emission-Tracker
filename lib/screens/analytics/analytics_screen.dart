import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.blue,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Fuel Consumption Analytics',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildCard(
              Icons.local_gas_station,
              Colors.blue,
              'Total Fuel Logged',
              '72 Litres',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.eco,
              Colors.green,
              'Total CO₂ Emissions',
              '166.3 kg',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.directions_car,
              Colors.orange,
              'Registered Vehicles',
              '2 Vehicles',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.speed,
              Colors.purple,
              'Average Fuel Efficiency',
              '18.0 km/L',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.attach_money,
              Colors.teal,
              'Estimated Monthly Fuel Cost',
              'KES 12,240',
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Insights',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                title: Text(
                  'Fuel consumption remained stable across recent logs.',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.speed,
                  color: Colors.blue,
                ),
                title: Text(
                  'Average fuel efficiency indicates economical driving habits.',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.eco,
                  color: Colors.green,
                ),
                title: Text(
                  'Estimated carbon emissions remain within acceptable limits.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    Color color,
    String title,
    String value,
  ) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}