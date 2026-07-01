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
              'Recommendations',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildRecommendation(
              Icons.eco,
              Colors.green,
              'Drive at a steady speed',
              'Smooth acceleration and braking improve fuel efficiency.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.tire_repair,
              Colors.orange,
              'Maintain tyre pressure',
              'Correct tyre pressure reduces fuel consumption.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.timer_off,
              Colors.red,
              'Reduce unnecessary idling',
              'Turn off the engine when parked for long periods.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.route,
              Colors.blue,
              'Combine short trips',
              'Planning errands together saves fuel and reduces emissions.',
            ),

            const SizedBox(height: 15),

            _buildRecommendation(
              Icons.build,
              Colors.purple,
              'Service your vehicle regularly',
              'Routine maintenance keeps your engine running efficiently.',
            ),

            const SizedBox(height: 30),

            const Text(
              'Overall Recommendation',
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
                  size: 35,
                ),

                title: Text(
                  'Efficient Driver',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),

                subtitle: Padding(
                  padding: EdgeInsets.only(top: 8),

                  child: Text(
                    'Your driving habits are fuel-efficient. Continue maintaining your vehicle regularly and monitor your fuel usage to keep emissions low.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
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