import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class EmissionsScreen extends StatelessWidget {
  const EmissionsScreen({super.key});

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

    double axioEmission = 20 * 2.31;
    double noteEmission = 35 * 2.31;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emissions'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

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

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.directions_car,
                  color: Colors.blue,
                ),

                title: const Text(
                  'Toyota Axio',
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      '${axioEmission.toStringAsFixed(1)} kg CO₂',
                    ),

                    Text(
                      getStatus(axioEmission),
                      style: TextStyle(
                        color: getStatusColor(axioEmission),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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

                title: const Text(
                  'Nissan Note',
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      '${noteEmission.toStringAsFixed(1)} kg CO₂',
                    ),

                    Text(
                      getStatus(noteEmission),
                      style: TextStyle(
                        color: getStatusColor(noteEmission),
                        fontWeight: FontWeight.bold,
                      ),
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
}