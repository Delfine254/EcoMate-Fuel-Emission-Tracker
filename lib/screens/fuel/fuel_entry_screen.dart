import 'package:flutter/material.dart';
import 'fuel_history_screen.dart';


class FuelEntryScreen extends StatefulWidget {
  const FuelEntryScreen({super.key});

  @override
  State<FuelEntryScreen> createState() => _FuelEntryScreenState();
}

class _FuelEntryScreenState extends State<FuelEntryScreen> {

  TextEditingController fuelController =
      TextEditingController();

  TextEditingController odometerController =
      TextEditingController();

  String selectedVehicle = 'Toyota Axio';
  String currentDate =
    DateTime.now().toString().split(' ')[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Entry'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: SingleChildScrollView(
          child: Column(
            children: [

              DropdownButtonFormField<String>(
                value: selectedVehicle,

                decoration: InputDecoration(
                  labelText: 'Vehicle',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),

                items: const [
                  DropdownMenuItem(
                    value: 'Toyota Axio',
                    child: Text('Toyota Axio'),
                  ),
                  DropdownMenuItem(
                    value: 'Nissan Note',
                    child: Text('Nissan Note'),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedVehicle = value!;
                  });
                },
              ),

              SizedBox(height: 20),

              TextField(
                controller: fuelController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: 'Fuel Added (Litres)',
                  prefixIcon: Icon(Icons.local_gas_station),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: odometerController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: 'Current Odometer (km)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
              ),

Card(
  child: ListTile(
    leading: Icon(Icons.calendar_today),

    title: Text('Date'),

    subtitle: Text(currentDate),
  ),
),

SizedBox(height: 20),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          const FuelHistoryScreen(),
    ),
  );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),

                  child: const Text(
                    'Save Fuel Entry',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}