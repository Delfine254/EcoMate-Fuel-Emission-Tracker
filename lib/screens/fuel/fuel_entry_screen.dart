import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/fuel_log_model.dart';
import '../../models/vehicle_model.dart';
import 'fuel_history_screen.dart';

class FuelEntryScreen extends StatefulWidget {
  const FuelEntryScreen({super.key});

  @override
  State<FuelEntryScreen> createState() => _FuelEntryScreenState();
}

class _FuelEntryScreenState extends State<FuelEntryScreen> {
  final TextEditingController fuelController = TextEditingController();
  final TextEditingController odometerController = TextEditingController();

  List<Vehicle> vehicles = [];

  String? selectedVehicle;

  final String currentDate =
      DateTime.now().toString().split(' ')[0];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

  Future<void> loadVehicles() async {
  final data = await DatabaseHelper.getVehicles();

  final savedVehicle =
      await DatabaseHelper.loadSelectedVehicle();

  setState(() {
    vehicles = data;

    if (vehicles.isEmpty) {
  selectedVehicle = null;
  DatabaseHelper.selectedVehicle = null;
  return;
}

    if (savedVehicle != null &&
        vehicles.any((v) => v.name == savedVehicle)) {

      selectedVehicle = savedVehicle;

    } else {

      selectedVehicle = vehicles.first.name;

      DatabaseHelper.selectedVehicle =
          selectedVehicle;

      DatabaseHelper.saveSelectedVehicle(
          selectedVehicle!);
    }

    DatabaseHelper.selectedVehicle =
        selectedVehicle;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Entry'),
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 30,
    ),
    child: SizedBox(
      width: 900,
      child: Column(
            children: [

              if (vehicles.isEmpty)

                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'No vehicles found.\nPlease add a vehicle first.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )

              else

                DropdownButtonFormField<String>(
                  value: selectedVehicle,

                  decoration: const InputDecoration(
                    labelText: 'Vehicle',
                    prefixIcon: Icon(Icons.directions_car),
                    border: OutlineInputBorder(),
                  ),

                  items: vehicles.map((vehicle) {
                    return DropdownMenuItem<String>(
                      value: vehicle.name,
                      child: Text(vehicle.name),
                    );
                  }).toList(),

 onChanged: (value) async {
  setState(() {
    selectedVehicle = value!;
    DatabaseHelper.selectedVehicle = value;
  });

  await DatabaseHelper.saveSelectedVehicle(value!);
},
                ),

              const SizedBox(height: 20),

              TextField(
                controller: fuelController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Fuel Added (Litres)',
                  prefixIcon: Icon(Icons.local_gas_station),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: odometerController,
                keyboardType: TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Current Odometer (km)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date'),
                  subtitle: Text(currentDate),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () async {

                    if (vehicles.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please add a vehicle first.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (fuelController.text.trim().isEmpty ||
                        odometerController.text.trim().isEmpty) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please fill in all fields.',
                          ),
                        ),
                      );

                      return;
                    }

                    try {

                      FuelLog fuelLog = FuelLog(
                        userEmail: DatabaseHelper.currentUserEmail!,
                        vehicleName: selectedVehicle!,
                        litres: double.tryParse(
                              fuelController.text,
                            ) ??
                            0,
                        odometer: double.tryParse(
                              odometerController.text,
                            ) ??
                            0,
                        date: currentDate,
                      );

                      await DatabaseHelper.insertFuelLog(
                        fuelLog,
                      );

                      fuelController.clear();
                      odometerController.clear();

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Fuel entry saved successfully!',
                          ),
                        ),
                      );

                    } catch (e) {

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                        ),
                      );

                    }

                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),

                  child: const Text(
                    'Save Fuel Entry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,

                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const FuelHistoryScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    'View Fuel History',
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      ),
    );
  }
}