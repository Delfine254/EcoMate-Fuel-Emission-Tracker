import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../widgets/custom_drawer.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  double totalFuel = 0;
  double totalEmissions = 0;
  int vehicleCount = 0;
  int fuelEntries = 0;

  double averageFuel = 0;
  double highestRefill = 0;
  double lowestRefill = 0;
  double estimatedCost = 0;

  @override
  void initState() {
    super.initState();
    loadAnalytics();
  }

  Future<void> loadAnalytics() async {

    totalFuel =
        await DatabaseHelper.getSelectedVehicleFuelUsed();

    totalEmissions =
        await DatabaseHelper.getSelectedVehicleEmissions();

    vehicleCount =
        await DatabaseHelper.getVehicleCount();

    fuelEntries =
        await DatabaseHelper.getSelectedVehicleEntries();

highestRefill =
    await DatabaseHelper.getHighestFuelRefill();

lowestRefill =
    await DatabaseHelper.getLowestFuelRefill();

if (fuelEntries > 0) {
  averageFuel = totalFuel / fuelEntries;
}

estimatedCost = totalFuel * 180;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

  appBar: AppBar(
    title : const Text('Analytics'),
  backgroundColor: Colors.blue,
  ),

      drawer: const CustomDrawer(),

      body: Padding(
  padding: const EdgeInsets.only(
    left: 40,
    right: 20,
    top: 24,
  ),
  child: SingleChildScrollView(
    child: SizedBox(
      width: 650,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
  'Fuel Consumption Analytics',
  style: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Color(0xFF374151),
  ),
),

            const SizedBox(height: 20),

            _buildCard(
              Icons.local_gas_station,
              Colors.blue,
              'Total Fuel Logged',
              '${totalFuel.toStringAsFixed(1)} Litres',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.eco,
              Colors.green,
              'Total CO₂ Emissions',
              '${totalEmissions.toStringAsFixed(1)} kg',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.directions_car,
              Colors.orange,
              'Registered Vehicles',
              '$vehicleCount Vehicles',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.analytics,
              Colors.purple,
              'Fuel Entries',
              '$fuelEntries Entries',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.local_gas_station,
              Colors.teal,
              'Average Fuel Per Entry',
              '${averageFuel.toStringAsFixed(1)} Litres',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.arrow_upward,
              Colors.red,
              'Highest Fuel Refill',
              '${highestRefill.toStringAsFixed(1)} Litres',
            ),

            const SizedBox(height: 15),

            _buildCard(
              Icons.arrow_downward,
              Colors.indigo,
              'Lowest Fuel Refill',
              '${lowestRefill.toStringAsFixed(1)} Litres',
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  title: Text(
                    fuelEntries > 5
                        ? 'Great! You are consistently tracking your fuel usage.'
                        : 'Keep adding fuel logs for better analytics.',
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.local_gas_station,
                  color: Colors.blue,
                ),
                title: Text(
                  averageFuel > 20
                      ? 'Your average refill is relatively high.'
                      : 'Your average refill is within the normal range.',
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
                  totalEmissions > 200
                      ? 'Consider reducing fuel consumption to lower emissions.'
                      : 'Your estimated emissions remain within acceptable limits.',
                ),
              ),
            ),

          ],
        ),
      ),
    ),
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