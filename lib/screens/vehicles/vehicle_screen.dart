import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import 'add_vehicle_screen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {

  List<Map<String, String>> vehicles = [
    {
      'name': 'Toyota Axio',
      'fuel': 'Petrol',
      'efficiency': '15',
    },
    {
      'name': 'Nissan Note',
      'fuel': 'Petrol',
      'efficiency': '18',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Management'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AddVehicleScreen(),
                    ),
                  );
                },

                icon: const Icon(Icons.add),

                label: const Text('Add Vehicle'),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,

                itemBuilder: (context, index) {

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.directions_car,
                        color: Colors.blue,
                      ),

                      title: Text(
                        vehicles[index]['name']!,
                      ),

                      subtitle: Text(
                        '${vehicles[index]['fuel']} • ${vehicles[index]['efficiency']} km/L',
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