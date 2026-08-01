import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/vehicle_model.dart';
import '../../models/fuel_log_model.dart';
import '../../widgets/custom_drawer.dart';

class EmissionsScreen extends StatefulWidget {
  const EmissionsScreen({super.key});

  @override
  State<EmissionsScreen> createState() => _EmissionsScreenState();
}

class _EmissionsScreenState extends State<EmissionsScreen> {
  List<Vehicle> vehicles = [];
  List<FuelLog> fuelLogs = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    vehicles = await DatabaseHelper.getVehicles();
    fuelLogs = await DatabaseHelper.getFuelLogs();

    setState(() {});
  }

  String getStatus(double emissions) {
    if (emissions <= 50) {
      return 'Efficient';
    } else if (emissions <= 90) {
      return 'Moderate';
    } else {
      return 'High Consumption';
    }
  }

  Color getStatusColor(double emissions) {
    if (emissions <= 50) {
      return Colors.green;
    } else if (emissions <= 90) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emissions'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: Padding(
  padding: const EdgeInsets.only(
    left: 40,
    right: 20,
    top: 24,
  ),

  child: SizedBox(
    width: 650,

    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Vehicle Emissions',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,

                itemBuilder: (context, index) {

                  final vehicle = vehicles[index];

                  double litres = fuelLogs
                      .where((log) =>
                          log.vehicleName == vehicle.name)
                      .fold(
                        0.0,
                        (sum, log) => sum + log.litres,
                      );

                  double factor = 2.31;

                  if (vehicle.fuelType == 'Diesel') {
                    factor = 2.68;
                  } else if (vehicle.fuelType == 'Hybrid') {
                    factor = 1.80;
                  } else if (vehicle.fuelType == 'Electric') {
                    factor = 0;
                  }

                  double emissions = litres * factor;

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.directions_car,
                        color: Colors.blue,
                      ),

                      title: Text(vehicle.name),

                      subtitle: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            '${emissions.toStringAsFixed(1)} kg CO₂',
                          ),

                          Text(
                            getStatus(emissions),
                            style: TextStyle(
                              color: getStatusColor(emissions),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}