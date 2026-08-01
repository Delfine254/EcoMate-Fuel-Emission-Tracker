import 'dart:typed_data';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

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

  if (selectedFilter == 'All Time') {
  totalFuel =
      await DatabaseHelper.getSelectedVehicleFuelUsed();

  totalEmissions =
      await DatabaseHelper.getSelectedVehicleEmissions();
} else {
  totalFuel =
      await DatabaseHelper.getFilteredFuelUsed(
    selectedFilter,
  );

  totalEmissions =
      await DatabaseHelper.getFilteredEmissions(
    selectedFilter,
  );
}

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
              'Total CO2 Emissions: ${totalEmissions.toStringAsFixed(1)} kg',
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
  'This report summarizes your recorded fuel consumption, estimated carbon emissions, fuel efficiency and forecast trends.',
),

pw.SizedBox(height: 12),

pw.Text(
  'Recommendation:',
  style: pw.TextStyle(
    fontWeight: pw.FontWeight.bold,
  ),
),

pw.SizedBox(height: 5),

pw.Text(
  'Continue monitoring fuel usage, service your vehicle(s) regularly and follow EcoMate recommendations to improve fuel economy and reduce environmental impact.',
),
          ],

        );

      },

    ),

  );

  String? outputFile = await FilePicker.platform.saveFile(
  dialogTitle: 'Save EcoMate Report',
  fileName: 'EcoMate_Report.pdf',
  type: FileType.custom,
  allowedExtensions: ['pdf'],
);

if (outputFile != null) {

  if (outputFile != null && !outputFile.toLowerCase().endsWith('.pdf')) {
  outputFile = '$outputFile.pdf';
}

  final file = File(outputFile);

  await file.writeAsBytes(
    await pdf.save(),
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'PDF saved successfully!',
      ),
    ),
  );
}

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

      body: Padding(
  padding: const EdgeInsets.only(
    left: 20,
    right: 20,
    top: 24,
  ),

  child: SizedBox(
    width: 800,

    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              reportTitle,
              style: TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Color(0xFF374151),
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
              'Total CO2 Emissions',
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
              'Forecast CO2 Emissions',
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

              child: Padding(
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
                  'Download Report (PDF)',
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
    ),
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

      child: Padding(
  padding: const EdgeInsets.symmetric(
    vertical: 6,
  ),
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
      ),
    );
  }
}