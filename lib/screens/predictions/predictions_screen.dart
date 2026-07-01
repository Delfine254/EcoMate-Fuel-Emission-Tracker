import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class PredictionsScreen extends StatelessWidget {
  const PredictionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Fuel Consumption Forecast',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildPredictionCard(
              Icons.local_gas_station,
              Colors.blue,
              'Expected Fuel Usage',
              '72 Litres',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.eco,
              Colors.green,
              'Expected CO₂ Emissions',
              '166 kg',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.trending_up,
              Colors.orange,
              'Monthly Trend',
              'Slight Increase',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.verified,
              Colors.purple,
              'Prediction Confidence',
              'High',
            ),

            const SizedBox(height: 30),

            const Text(
              'Prediction Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.insights,
                  color: Colors.blue,
                ),

                title: Text(
                  'Based on your recent fuel usage, EcoMate predicts a slight increase in fuel consumption this month.',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(
                  Icons.lightbulb,
                  color: Colors.amber,
                ),

                title: Text(
                  'Maintaining your current driving habits could keep emissions below 170 kg CO₂.',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildPredictionCard(
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