import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../widgets/custom_drawer.dart';

class PredictionsScreen extends StatefulWidget {
  const PredictionsScreen({super.key});

  @override
  State<PredictionsScreen> createState() =>
      _PredictionsScreenState();
}

class _PredictionsScreenState
    extends State<PredictionsScreen> {

  double predictedFuel = 0;
  double predictedEmissions = 0;
  int fuelEntries = 0;

  @override
  void initState() {
    super.initState();
    loadPredictions();
  }

  Future<void> loadPredictions() async {

    predictedFuel =
        await DatabaseHelper.getPredictedMonthlyFuelUsage();

    predictedEmissions =
        await DatabaseHelper.getPredictedMonthlyEmissions();

    fuelEntries =
        await DatabaseHelper.getFuelEntryCount();

    setState(() {});
  }

  String getConfidence() {

    if (fuelEntries >= 10) {
      return "High";
    }

    if (fuelEntries >= 5) {
      return "Medium";
    }

    return "Low";
  }

  String getTrend() {

    if (predictedFuel > 100) {
      return "Increasing";
    }

    if (predictedFuel > 50) {
      return "Stable";
    }

    return "Low Usage";
  }

  double getProjectedCost() {
    return predictedFuel * 180;
  }

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
              '${predictedFuel.toStringAsFixed(1)} Litres',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.eco,
              Colors.green,
              'Expected CO₂ Emissions',
              '${predictedEmissions.toStringAsFixed(1)} kg',
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.trending_up,
              Colors.orange,
              'Expected Fuel Trend',
              getTrend(),
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.psychology,
              Colors.purple,
              'Prediction Confidence',
              getConfidence(),
            ),

            const SizedBox(height: 15),

            _buildPredictionCard(
              Icons.savings,
              Colors.teal,
              'Projected Fuel Cost',
              'KES ${getProjectedCost().toStringAsFixed(0)}',
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
                leading: const Icon(
                  Icons.insights,
                  color: Colors.blue,
                ),
                title: Text(
                  'Based on your previous fuel records, EcoMate predicts approximately ${predictedFuel.toStringAsFixed(1)} litres of fuel may be consumed during your next month of driving.',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.lightbulb,
                  color: Colors.amber,
                ),
                title: Text(
                  predictedFuel > 100
                      ? 'Fuel usage is increasing. Consider smoother driving habits and regular vehicle servicing.'
                      : 'Current fuel usage appears stable. Continue maintaining efficient driving habits.',
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.eco,
                  color: Colors.green,
                ),
                title: Text(
                  'Estimated carbon emissions for next month are ${predictedEmissions.toStringAsFixed(1)} kg based on your current usage pattern.',
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