import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../database/database_helper.dart';
import '../../widgets/custom_drawer.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  double totalFuel = 0;
  double totalEmissions = 0;
  int vehicleCount = 0;

  final double averageEfficiency = 16.5;

  String selectedFilter = 'All Time';

  String get reportTitle {
    switch (selectedFilter) {
      case 'Today':
        return 'EcoMate Daily Report';

      case 'This Week':
        return 'EcoMate Weekly Report';

      case 'This Month':
        return 'EcoMate Monthly Report';

      default:
        return 'EcoMate Summary Report';
    }
  }

  @override
  void initState() {
    super.initState();
    loadReportData();
  }

  Future<void> loadReportData() async {

  totalFuel =
      await DatabaseHelper.getFilteredFuelUsed(
    selectedFilter,
  );

  totalEmissions =
      await DatabaseHelper.getFilteredEmissions(
    selectedFilter,
  );

  vehicleCount =
      await DatabaseHelper.getVehicleCount();

  setState(() {});
}

  String getCurrentDate() {
    DateTime now = DateTime.now();

    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }

Future<void> exportPDF() async {

  final pdf = pw.Document();

  double forecastEmission = totalEmissions * 1.15;

  pdf.addPage(

    pw.Page(

      pageFormat: PdfPageFormat.a4,

      build: (context) {

        return pw.Column(

          crossAxisAlignment: pw.CrossAxisAlignment.start,

          children: [

            pw.Text(
              'EcoMate Summary Report',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),

            pw.SizedBox(height: 20),

            pw.Text(
              'Report Date: ${getCurrentDate()}',
            ),

            pw.Divider(),

            pw.Text(
              'Total Fuel Consumed: ${totalFuel.toStringAsFixed(1)} Litres',
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Total CO₂ Emissions: ${totalEmissions.toStringAsFixed(1)} kg',
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Registered Vehicles: $vehicleCount',
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Average Fuel Efficiency: ${averageEfficiency.toStringAsFixed(1)} km/L',
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'Forecast Emissions: ${forecastEmission.toStringAsFixed(1)} kg',
            ),

            pw.SizedBox(height: 25),

            pw.Text(
              'Summary',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 18,
              ),
            ),

            pw.SizedBox(height: 10),

            pw.Text(
              'This report summarizes your recorded fuel consumption, estimated carbon emissions, fuel efficiency and forecast trends. Continue monitoring fuel usage, servicing your vehicles regularly and following EcoMate recommendations to improve fuel economy and reduce environmental impact.',
            ),

          ],

        );

      },

    ),

  );

  await Printing.layoutPdf(

    onLayout: (PdfPageFormat format) async {

      return pdf.save();

    },

  );

}

  @override
  Widget build(BuildContext context) {
    double forecastEmission = totalEmissions * 1.15;

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

            Text(
              reportTitle,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 3,

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  children: [

                    const Icon(
                      Icons.filter_alt,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Report Period',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    DropdownButton<String>(
                      value: selectedFilter,

                      underline: const SizedBox(),

                      items: const [

                        DropdownMenuItem(
                          value: 'Today',
                          child: Text('Today'),
                        ),

                        DropdownMenuItem(
                          value: 'This Week',
                          child: Text('This Week'),
                        ),

                        DropdownMenuItem(
                          value: 'This Month',
                          child: Text('This Month'),
                        ),

                        DropdownMenuItem(
                          value: 'All Time',
                          child: Text('All Time'),
                        ),

                      ],

                      onChanged: (value) async {

  selectedFilter = value!;

  await loadReportData();

},
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            _buildReportCard(
              Icons.local_gas_station,
              Colors.orange,
              'Total Fuel Consumed',
              '${totalFuel.toStringAsFixed(1)} Litres',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.eco,
              Colors.green,
              'Total CO₂ Emissions',
              '${totalEmissions.toStringAsFixed(1)} kg',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.directions_car,
              Colors.blue,
              'Registered Vehicles',
              '$vehicleCount',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.speed,
              Colors.purple,
              'Average Fuel Efficiency',
              '${averageEfficiency.toStringAsFixed(1)} km/L',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.trending_up,
              Colors.red,
              'Forecast CO₂ Emissions',
              '${forecastEmission.toStringAsFixed(1)} kg',
            ),

            const SizedBox(height: 15),

            _buildReportCard(
              Icons.calendar_today,
              Colors.teal,
              'Report Date',
              getCurrentDate(),
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
                onPressed: exportPDF,

                icon: const Icon(Icons.picture_as_pdf),

                label: const Text(
                  'Export Report (PDF)',
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