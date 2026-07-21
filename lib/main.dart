import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/vehicles/vehicle_screen.dart';
import "screens/emissions/emissions_screen.dart";
import "screens/analytics/analytics_screen.dart";
import "screens/predictions/predictions_screen.dart";
import "screens/recommendations/recommendations_screen.dart";
import "screens/reports/reports_screen.dart";
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io';
import 'database/database_helper.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows ||
      Platform.isLinux ||
      Platform.isMacOS) {

    sqfliteFfiInit();

    databaseFactory = databaseFactoryFfi;

  }
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecomate',
      home: const SplashScreen(),
    );
  }
}