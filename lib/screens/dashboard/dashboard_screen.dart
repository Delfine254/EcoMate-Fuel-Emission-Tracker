import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('EcoMate Dashboard'),
        backgroundColor: Colors.blue,
      ),

      drawer: CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              'Welcome Back 👋',

              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Here is your fuel and emissions summary.',

              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 30),

            Row(
              children: [

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      children: [

                        Icon(
                          Icons.local_gas_station,
                          color: Colors.white,
                          size: 40,
                        ),

                        SizedBox(height: 10),

                        Text(
                          '245 L',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'Fuel Consumed',

                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(width: 15),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      children: [

                        Icon(
                          Icons.eco,
                          color: Colors.white,
                          size: 40,
                        ),

                        SizedBox(height: 10),

                        Text(
                          '120 KG',

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          'CO₂ Emissions',

                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}