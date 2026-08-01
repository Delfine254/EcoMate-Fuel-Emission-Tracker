import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../widgets/custom_drawer.dart';

class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() =>
      _RecommendationsScreenState();
}

class _RecommendationsScreenState
    extends State<RecommendationsScreen> {

  String recommendation = '';
  String efficiencyAdvice = '';
  String environmentalAdvice = '';

  double totalFuel = 0;
  double totalEmissions = 0;

  @override
  void initState() {
    super.initState();
    loadRecommendations();
  }

  Future<void> loadRecommendations() async {

    recommendation =
        await DatabaseHelper.getRecommendation();

    efficiencyAdvice =
        await DatabaseHelper.getEfficiencyAdvice();

    environmentalAdvice =
        await DatabaseHelper.getEnvironmentalAdvice();

    totalFuel =
        await DatabaseHelper.getTotalFuelUsed();

    totalEmissions =
        await DatabaseHelper.getTotalEmissions();

    setState(() {});
  }

  String getAssessment() {

    if (totalEmissions > 200) {
      return "Needs Improvement";
    }

    if (totalFuel > 100) {
      return "Fair";
    }

    return "Excellent";
  }

  Color getAssessmentColor() {

    if (totalEmissions > 200) {
      return Colors.red;
    }

    if (totalFuel > 100) {
      return Colors.orange;
    }

    return Colors.green;
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Recommendations"),
      backgroundColor: Colors.blue,
    ),

    drawer: const CustomDrawer(),

    body: Padding(
  padding: const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 24,
  ),

  child: SizedBox(
    width: 750,

    child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(
                  "Recommendations",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "EcoMate analyzes your fuel records and provides personalized recommendations.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 25),

                _buildRecommendation(
                  Icons.psychology,
                  Colors.blue,
                  "Overall Recommendation",
                  recommendation,
                ),

                const SizedBox(height: 15),

                _buildRecommendation(
                  Icons.speed,
                  Colors.orange,
                  "Fuel Efficiency",
                  efficiencyAdvice,
                ),

                const SizedBox(height: 15),

                _buildRecommendation(
                  Icons.eco,
                  Colors.green,
                  "Environmental Advice",
                  environmentalAdvice,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Overall Assessment",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Card(
                  color: getAssessmentColor().withOpacity(0.12),
                  elevation: 3,

                  child: ListTile(

                    leading: Icon(
                      Icons.verified,
                      color: getAssessmentColor(),
                      size: 36,
                    ),

                    title: Text(
                      getAssessment(),
                      style: TextStyle(
                        color: getAssessmentColor(),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),

                      child: Text(
                        recommendation,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
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