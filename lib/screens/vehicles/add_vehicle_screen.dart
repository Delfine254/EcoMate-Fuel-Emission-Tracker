import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/vehicle_model.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() =>
      _AddVehicleScreenState();
}

class _AddVehicleScreenState
    extends State<AddVehicleScreen> {

  String selectedFuelType = 'Petrol';

  TextEditingController vehicleNameController =
      TextEditingController();

  TextEditingController efficiencyController =
      TextEditingController(text: '15');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: vehicleNameController,

                decoration: const InputDecoration(
                  labelText: 'Vehicle Name',
                  prefixIcon:
                      Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedFuelType,

                decoration: const InputDecoration(
                  labelText: 'Fuel Type',
                  prefixIcon:
                      Icon(Icons.local_gas_station),
                  border: OutlineInputBorder(),
                ),

                items: const [

                  DropdownMenuItem(
                    value: 'Petrol',
                    child: Text('Petrol'),
                  ),

                  DropdownMenuItem(
                    value: 'Diesel',
                    child: Text('Diesel'),
                  ),

                  DropdownMenuItem(
                    value: 'Hybrid',
                    child: Text('Hybrid'),
                  ),

                  DropdownMenuItem(
                    value: 'Electric',
                    child: Text('Electric'),
                  ),
                ],

                onChanged: (value) {

                  setState(() {

                    selectedFuelType = value!;

                    if (value == 'Petrol') {
                      efficiencyController.text = '15';
                    } else if (value == 'Diesel') {
                      efficiencyController.text = '18';
                    } else if (value == 'Hybrid') {
                      efficiencyController.text = '25';
                    } else {
                      efficiencyController.text = '0';
                    }

                  });

                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: efficiencyController,
                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText:
                      'Fuel Efficiency (km/L)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () async {

  if (vehicleNameController.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter a vehicle name'),
      ),
    );

    return;
  }

  try {

    Vehicle vehicle = Vehicle(

      userEmail: DatabaseHelper.currentUserEmail!,

      name: vehicleNameController.text.trim(),

      fuelType: selectedFuelType,

      efficiency: double.tryParse(
            efficiencyController.text,
          ) ??
          0,

    );

    await DatabaseHelper.insertVehicle(vehicle);

    if (!context.mounted) return;

    Navigator.pop(context, true);

  } catch (e) {

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $e',
        ),
      ),
    );

    debugPrint(e.toString());

  }

},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                  ),

                  child: const Text(
                    'Save Vehicle',

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