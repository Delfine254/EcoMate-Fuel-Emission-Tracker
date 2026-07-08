import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'EcoMate Summary Report',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildReportCard(
              Icons.local_gas_station,
              Colors.orange,
              'Total Fuel Consumed',
              '55 Litres',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.eco,
              Colors.green,
              'Total CO₂ Emissions',
              '127 kg',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.directions_car,
              Colors.blue,
              'Registered Vehicles',
              '3',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.speed,
              Colors.purple,
              'Average Fuel Efficiency',
              '16.5 km/L',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.trending_up,
              Colors.red,
              'Forecast CO₂ Emissions',
              '173.3 kg',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.calendar_today,
              Colors.teal,
              'Report Date',
              '08 July 2026',
            ),

            const SizedBox(height: 30),

            const Text(
              'Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,

              child: const Padding(
                padding: EdgeInsets.all(16),

                child: Text(
                  'This report summarizes your recorded fuel consumption, estimated carbon emissions, fuel efficiency and forecast trends. Continue monitoring fuel usage, servicing your vehicles regularly and following EcoMate recommendations to improve fuel economy and reduce environmental impact.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {},

                icon: const Icon(Icons.picture_as_pdf),

                label: const Text(
                  'Export Report (Coming Soon)',
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(
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