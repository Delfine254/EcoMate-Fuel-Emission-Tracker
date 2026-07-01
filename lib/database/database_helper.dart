import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/vehicle_model.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'ecomate.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vehicles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            fuelType TEXT,
            efficiency REAL
          )
        ''');
      },
    );
  }

  // Insert a vehicle
  static Future<int> insertVehicle(Vehicle vehicle) async {
    final db = await database;

    return await db.insert(
      'vehicles',
      vehicle.toMap(),
    );
  }

  // Get all vehicles
  static Future<List<Vehicle>> getVehicles() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('vehicles');

    return List.generate(
      maps.length,
      (index) => Vehicle.fromMap(maps[index]),
    );
  }
}