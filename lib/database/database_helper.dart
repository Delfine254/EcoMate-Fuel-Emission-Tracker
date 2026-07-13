import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/vehicle_model.dart';
import '../models/fuel_log_model.dart';

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
      version: 2,

      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE vehicles(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            fuelType TEXT,
            efficiency REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE fuel_logs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            vehicleName TEXT,
            litres REAL,
            odometer REAL,
            date TEXT
          )
        ''');
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE fuel_logs(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              vehicleName TEXT,
              litres REAL,
              odometer REAL,
              date TEXT
            )
          ''');
        }
      },
    );
  }

  // ==========================
  // VEHICLES
  // ==========================

  static Future<int> insertVehicle(Vehicle vehicle) async {
    final db = await database;

    return await db.insert(
      'vehicles',
      vehicle.toMap(),
    );
  }

  static Future<List<Vehicle>> getVehicles() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('vehicles');

    return List.generate(
      maps.length,
      (index) => Vehicle.fromMap(maps[index]),
    );
  }

  static Future<int> deleteVehicle(int id) async {
    final db = await database;

    return await db.delete(
      'vehicles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==========================
  // FUEL LOGS
  // ==========================

  static Future<int> insertFuelLog(FuelLog fuelLog) async {
    final db = await database;

    return await db.insert(
      'fuel_logs',
      fuelLog.toMap(),
    );
  }

  static Future<List<FuelLog>> getFuelLogs() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query(
      'fuel_logs',
      orderBy: 'id DESC',
    );

    return List.generate(
      maps.length,
      (index) => FuelLog.fromMap(
        maps[index],
      ),
    );
  }

  // ==========================
  // REPORT CALCULATIONS
  // ==========================

  static Future<double> getTotalFuelUsed() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT SUM(litres) AS total FROM fuel_logs',
    );

    return (result.first['total'] as num?)?.toDouble() ?? 0.0;
  }

  static Future<int> getVehicleCount() async {
    final db = await database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM vehicles',
    );

    return (result.first['total'] as int?) ?? 0;
  }

  static Future<double> getTotalEmissions() async {
    double totalFuel = await getTotalFuelUsed();

    return totalFuel * 2.31;
  }

  // ==========================
  // DATABASE RESET (Development Only)
  // ==========================

  static Future<void> deleteDatabaseFile() async {
    String path = join(
      await getDatabasesPath(),
      'ecomate.db',
    );

    await deleteDatabase(path);

    _database = null;
  }
}