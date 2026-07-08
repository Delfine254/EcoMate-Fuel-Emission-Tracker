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
              'Fuel Consumption Predictions',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildPredictionCard(
              Icons.local_gas_station,
              Colors.blue,
              'Expected Fuel Consumption',
              '75 Litres',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.eco,
              Colors.green,
              'Expected CO₂ Emissions',
              '173.3 kg',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.trending_up,
              Colors.orange,
              'Expected Fuel Trend',
              'Slight Increase',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.psychology,
              Colors.purple,
              'Prediction Confidence',
              'High',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.savings,
              Colors.teal,
              'Projected Fuel Cost',
              'KES 12,800',
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
                  'Based on recent fuel records, EcoMate forecasts a slight increase in fuel consumption over the next month.',
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
                  'Maintaining smooth acceleration and regular vehicle servicing can help reduce future fuel consumption.',
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
                  'Projected carbon emissions are expected to remain within an acceptable environmental range.',
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