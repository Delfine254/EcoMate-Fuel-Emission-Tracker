import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
        backgroundColor: Colors.blue,
      ),

      drawer: const CustomDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Smart Recommendations',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'EcoMate recommends the following actions to improve fuel efficiency and reduce carbon emissions.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            _buildRecommendation(
              Icons.speed,
              Colors.blue,
              'Maintain a steady driving speed',
              'Avoid sudden acceleration and harsh braking to improve fuel efficiency.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.tire_repair,
              Colors.orange,
              'Maintain correct tyre pressure',
              'Properly inflated tyres reduce rolling resistance and improve fuel economy.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.engineering,
              Colors.purple,
              'Schedule regular vehicle servicing',
              'Routine maintenance keeps the engine operating efficiently and reduces emissions.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.route,
              Colors.teal,
              'Plan efficient travel routes',
              'Combining trips and avoiding traffic congestion helps lower fuel consumption.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.eco,
              Colors.green,
              'Monitor fuel consumption regularly',
              'Review your fuel records frequently to identify unusual increases in fuel usage.',
            ),

            const SizedBox(height: 30),

            const Text(
              'Overall Assessment',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Card(
              color: Colors.green.shade50,
              elevation: 3,

              child: const ListTile(
                leading: Icon(
                  Icons.verified,
                  color: Colors.green,
                  size: 36,
                ),

                title: Text(
                  'Good Fuel Management',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8),

                  child: Text(
                    'Your recent fuel records indicate efficient vehicle usage. Continue following EcoMate recommendations to maintain good fuel economy and minimize environmental impact.',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendation(
    IconData icon,
    Color color,
    String title,
    String description,
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

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(description),
      ),
    );
  }
}