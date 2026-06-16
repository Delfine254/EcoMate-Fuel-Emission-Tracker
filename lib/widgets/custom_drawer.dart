import 'package:flutter/material.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/vehicles/vehicle_screen.dart';
import '../screens/fuel/fuel_entry_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/emissions/emissions_screen.dart';
import '../screens/predictions/predictions_screen.dart';
import '../screens/recommendations/recommendations_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/auth/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,

        children: [

          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Icon(
                  Icons.local_gas_station,
                  color: Colors.white,
                  size: 50,
                ),

                SizedBox(height: 10),

                Text(
                  'EcoMate',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),

          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Dashboard'),

            onTap: () {
Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => DashboardScreen(),
    ),
  );
            },
          ),

          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Vehicles'),

            onTap: () {
 Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => VehicleScreen(),
    ),
  );
            },
          ),

          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Fuel Entry'),

            onTap: () {
 Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => FuelEntryScreen(),
    ),
  );
            },
          ),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Analytics'),

            onTap: () {
 Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => AnalyticsScreen(),
    ),
  );

            },
          ),

          ListTile(
            leading: Icon(Icons.eco),
            title: Text('Emissions'),

            onTap: () {
 Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => EmissionsScreen(),
    ),
  );
            },
          ),

          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Predictions'),

            onTap: () {
  Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => PredictionsScreen(),
    ),
  );

            },
          ),

          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Recommendations'),

            onTap: () {
 Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => RecommendationsScreen(),
    ),
  );
            },
          ),

          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Reports'),

            onTap: () {
Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => ReportsScreen(),
    ),
  );
            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),

            onTap: () {
Navigator.push(
    context,

    MaterialPageRoute(
      builder: (context) => LoginScreen(),
    ),
  );
            },
          ),

        ],
      ),
    );
  }
}