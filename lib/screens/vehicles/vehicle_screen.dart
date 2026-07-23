import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/vehicle_model.dart';
import '../../widgets/custom_drawer.dart';
import 'add_vehicle_screen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    loadVehicles();
  }

 Future<void> loadVehicles() async {
  final data = await DatabaseHelper.getVehicles();

  setState(() {
    vehicles = data;
  });
}

  Future<void> deleteVehicle(Vehicle vehicle) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Vehicle'),

          content: Text(
            'Are you sure you want to delete "${vehicle.name}"?',
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text('Cancel'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () {
                Navigator.pop(context, true);
              },

              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await DatabaseHelper.deleteVehicle(vehicle.id!);

      loadVehicles();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vehicle deleted successfully.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'My Vehicles',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () async {

                  bool? saved = await Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                          const AddVehicleScreen(),
                    ),
                  );

                  if (saved == true) {
                    loadVehicles();
                  }
                },

                icon: const Icon(Icons.add),

                label: const Text(
                  'Add Vehicle',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: vehicles.isEmpty

                  ? const Center(
                      child: Text(
                        'No vehicles added yet.',
                      ),
                    )

                  : ListView.builder(

                      itemCount: vehicles.length,

                      itemBuilder: (context, index) {

                        final vehicle = vehicles[index];

                        return Card(

                          child: ListTile(

                            leading: const Icon(
                              Icons.directions_car,
                              color: Colors.blue,
                            ),

                            title: Text(vehicle.name),

                            subtitle: Text(
                              '${vehicle.fuelType} • ${vehicle.efficiency} km/L',
                            ),

                            trailing: IconButton(

                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),

                              onPressed: () {
                                deleteVehicle(vehicle);
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}