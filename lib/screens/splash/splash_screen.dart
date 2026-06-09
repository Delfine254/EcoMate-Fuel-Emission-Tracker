import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
    const SplashScreen({super.key});
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                            Icons.local_gas_station,
                            size: 80,
                            color: Colors.blue,
                        ),

                        SizedBox(height: 20),

                        Text(
                            'EcoMate',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                            ),
                        ),

                        SizedBox(height: 10),

                        Text(
                            'Fuel Consumption & Emission Tracker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                            )
                        ),

                        SizedBox(height: 30),

                        Text(
                            'Loading...', 
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                            )
                        ),
                    ],
                ),
            ),
        );
    }
}