import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

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

                },

                icon: const Icon(Icons.add),

                label: const Text('Add Vehicle'),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.directions_car,
                  color: Colors.blue,
                ),

                title: const Text('Toyota Axio'),

                subtitle: const Text(
                  'Petrol • 15 km/L',
                ),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.directions_car,
                  color: Colors.green,
                ),

                title: const Text('Nissan Note'),

                subtitle: const Text(
                  'Petrol • 18 km/L',
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}