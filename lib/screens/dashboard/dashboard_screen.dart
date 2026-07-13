import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../widgets/custom_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  double totalFuel = 0;
  double totalEmissions = 0;
  int vehicleCount = 0;

  @override
  void initState() {
    super.initState();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {

    totalFuel =
        await DatabaseHelper.getTotalFuelUsed();

    totalEmissions =
        await DatabaseHelper.getTotalEmissions();

    vehicleCount =
        await DatabaseHelper.getVehicleCount();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('EcoMate Dashboard'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              'Welcome Back 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Here is your fuel and emissions summary.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.blue,
                    icon: Icons.local_gas_station,
                    value:
                        '${totalFuel.toStringAsFixed(1)} L',
                    title: 'Fuel Consumed',
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.green,
                    icon: Icons.eco,
                    value:
                        '${totalEmissions.toStringAsFixed(1)} kg',
                    title: 'CO₂ Emissions',
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.orange,
                    icon: Icons.directions_car,
                    value: '$vehicleCount',
                    title: 'Vehicles',
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.purple,
                    icon: Icons.analytics,
                    value: 'Live',
                    title: 'Data Status',
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Quick Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,

              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Text(
                  'You have registered $vehicleCount vehicle(s), recorded ${totalFuel.toStringAsFixed(1)} litres of fuel and generated approximately ${totalEmissions.toStringAsFixed(1)} kg of CO₂ emissions. Continue logging fuel usage regularly for more accurate reports and predictions.',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required Color color,
    required IconData icon,
    required String value,
    required String title,
  }) {

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(15),
      ),

      child: Column(

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}