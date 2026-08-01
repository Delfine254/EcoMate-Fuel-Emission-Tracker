import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/fuel_log_model.dart';

class FuelHistoryScreen extends StatefulWidget {
  const FuelHistoryScreen({super.key});

  @override
  State<FuelHistoryScreen> createState() =>
      _FuelHistoryScreenState();
}

class _FuelHistoryScreenState
    extends State<FuelHistoryScreen> {

  List<FuelLog> fuelLogs = [];

  @override
  void initState() {
    super.initState();
    loadFuelLogs();
  }

  Future<void> loadFuelLogs() async {

    final logs =
        await DatabaseHelper.getFuelLogs();

    setState(() {
      fuelLogs = logs;
    });

  }

  double calculateEmission(double litres) {
    return litres * 2.31;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Fuel History'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
        ),

        child: SizedBox(
          width: 900,

          child: fuelLogs.isEmpty

              ? const Center(
                  child: Text(
                    'No fuel records found.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )

              : ListView.builder(

                  itemCount: fuelLogs.length,

                  itemBuilder: (context, index) {

                    final log = fuelLogs[index];

                    return Card(

                      margin: const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(

                        leading: const Icon(
                          Icons.local_gas_station,
                          color: Colors.blue,
                        ),

                        title: Text(
                          log.vehicleName,
                        ),

                        subtitle: Text(
                          '${log.litres} L • '
                          '${log.odometer} km\n'
                          '${log.date}\n\n'
                          'Estimated CO₂: '
                          '${calculateEmission(log.litres).toStringAsFixed(1)} kg',
                        ),

                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}