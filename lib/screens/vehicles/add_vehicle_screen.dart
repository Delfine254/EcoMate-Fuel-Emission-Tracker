import 'package:flutter/material.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  String selectedFuelType = 'Petrol';

  TextEditingController efficiencyController =
      TextEditingController(text: '15');

      TextEditingController vehicleNameController =
    TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: vehicleNameController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Name',
                  prefixIcon: Icon(Icons.directions_car),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedFuelType,

                decoration: InputDecoration(
                  labelText: 'Fuel Type',
                  prefixIcon: Icon(Icons.local_gas_station),
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

              SizedBox(height: 20),

              TextField(
                controller: efficiencyController,

                decoration: InputDecoration(
                  labelText: 'Fuel Efficiency (km/L)',
                  prefixIcon: Icon(Icons.speed),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
 Map<String, String> newVehicle = {
    'name': vehicleNameController.text,
    'fuel': selectedFuelType,
    'efficiency': efficiencyController.text,
  };

  Navigator.pop(context, newVehicle);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
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