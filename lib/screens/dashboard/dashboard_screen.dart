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

  String currentVehicle = "No Vehicle";
String userName = "User";
String lastFuelEntry = "--";

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

  currentVehicle =
      DatabaseHelper.selectedVehicle ?? "No Vehicle";

  final user =
      await DatabaseHelper.getLoggedInUser();

  if (user != null) {
    userName = user.fullName.split(" ").first;
  }

  setState(() {});
}
    String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 17) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  title: const Text(
    "EcoMate",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: Colors.green,
      letterSpacing: 0.3,
    ),
  ),
),

      drawer: const CustomDrawer(),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    Text(
      "${getGreeting()}, $userName 👋",
      style: const TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: Color(0xFF374151), // Dark Grey
),
    ),

    const SizedBox(height: 30),

    const Text(
      "Current Vehicle",
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    ),

    const SizedBox(height: 8),

    Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.directions_car,
          color: Colors.blue,
        ),
        title: Text(
          currentVehicle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),

    const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.green,
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
                    color: Colors.green,
                    icon: Icons.directions_car,
                    value: '$vehicleCount',
                    title: 'Registered Vehicles',
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _buildSummaryCard(
                    color: Colors.green,
                    icon: Icons.analytics,
                    value: 'Synced',
                    title: 'Data Status',
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

  const Text(
  "Today's Overview",
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Color(0xFF374151),
  ),
),

const SizedBox(height: 15),

Card(
  elevation: 3,
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Current Vehicle: $currentVehicle',
          style: const TextStyle(fontSize: 16),
        ),

        const SizedBox(height: 8),

        const Text(
          'System Status: Synced',
          style: TextStyle(fontSize: 16),
        ),
      ],
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