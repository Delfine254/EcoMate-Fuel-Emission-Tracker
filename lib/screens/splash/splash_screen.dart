import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Column(
                    children: [
                        Icon(
                            Icons.local_gas_station,
                            size: 80,
                        ),

                        SizedBox(height: 20),

                        Text(
                            'EcoMate',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                            ),
                        ),

                        SizedBox(height: 10),

                        Text(
                            'Fuel Consumption & Emission Tracker',
                            textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 30),

                        Text(
                            'Loading...', 
                        ),
                    ],
                ),
            ),
        );
    }
}