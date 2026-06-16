import 'package:flutter/material.dart';

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

            },
          ),

          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Vehicles'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.local_gas_station),
            title: Text('Fuel Entry'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Analytics'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.eco),
            title: Text('Emissions'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.show_chart),
            title: Text('Predictions'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Recommendations'),

            onTap: () {

            },
          ),

          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('Reports'),

            onTap: () {

            },
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),

            onTap: () {

            },
          ),

        ],
      ),
    );
  }
}