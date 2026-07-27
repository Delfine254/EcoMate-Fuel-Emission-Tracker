import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/vehicle_model.dart';
import '../models/fuel_log_model.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static Database? _database;

static String? currentUserEmail;

static String? selectedVehicle;

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
      version: 3,

      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  fullName TEXT,
  email TEXT UNIQUE,
  password TEXT
)
''');

        await db.execute('''
          CREATE TABLE vehicles(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userEmail TEXT,
  name TEXT,
  fuelType TEXT,
  efficiency REAL
)
        ''');

        await db.execute('''
          CREATE TABLE fuel_logs(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userEmail TEXT,
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

  if (oldVersion < 3) {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT,
        email TEXT UNIQUE,
        password TEXT
      )
    ''');
  }
},
    );
  }
// ==========================
// USERS
// ==========================

static Future<int> insertUser(User user) async {
  final db = await database;

  return await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.abort,
  );
}

static Future<User?> loginUser(
  String email,
  String password,
) async {
  final db = await database;

  final result = await db.query(
    'users',
    where: 'email = ? AND password = ?',
    whereArgs: [email, password],
  );

  if (result.isNotEmpty) {
    return User.fromMap(result.first);
  }

  return null;
}

static Future<User?> getLoggedInUser() async {
  final db = await database;

  final result = await db.query(
    'users',
    where: 'email = ?',
    whereArgs: [currentUserEmail],
  );

  if (result.isEmpty) return null;

  return User.fromMap(result.first);
}

static Future<bool> emailExists(String email) async {
  final db = await database;

  final result = await db.query(
    'users',
    where: 'email = ?',
    whereArgs: [email],
  );

  return result.isNotEmpty;
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
      await db.query(
    'vehicles',
    where: 'userEmail = ?',
    whereArgs: [currentUserEmail],
  );

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
    where: 'userEmail = ?',
    whereArgs: [currentUserEmail],
    orderBy: 'id DESC',
  );

  return List.generate(
    maps.length,
    (index) => FuelLog.fromMap(
      maps[index],
    ),
  );
}

static Future<List<FuelLog>> getFuelLogsForVehicle(
    String vehicleName) async {

  final db = await database;

  final List<Map<String, dynamic>> maps = await db.query(
    'fuel_logs',
    where: 'vehicleName = ? AND userEmail = ?',
    whereArgs: [
      vehicleName,
      currentUserEmail,
    ],
    orderBy: 'id DESC',
  );

  return List.generate(
    maps.length,
    (index) => FuelLog.fromMap(maps[index]),
  );
}
  // ==========================
  // REPORT CALCULATIONS
  // ==========================

  static Future<double> getTotalFuelUsed() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT SUM(litres) AS total
    FROM fuel_logs
    WHERE userEmail = ?
    ''',
    [currentUserEmail],
  );

  return (result.first['total'] as num?)?.toDouble() ?? 0.0;
}

  static Future<int> getVehicleCount() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT COUNT(*) AS total
    FROM vehicles
    WHERE userEmail = ?
    ''',
    [currentUserEmail],
  );

  return (result.first['total'] as int?) ?? 0;
}

  static Future<double> getTotalEmissions() async {
    double totalFuel = await getTotalFuelUsed();

    return totalFuel * 2.31;
  }

// ==========================
// FILTERED REPORTS
// ==========================

static Future<double> getFilteredFuelUsed(String filter) async {
  final db = await database;

  String condition = '';

  switch (filter) {
    case 'Today':
      condition =
          "AND date = date('now','localtime')";
      break;

    case 'This Week':
      condition =
          "AND date >= date('now','-6 days')";
      break;

    case 'This Month':
      condition =
          "AND strftime('%Y-%m', date) = strftime('%Y-%m','now')";
      break;

    default:
      condition = '';
  }

  final result = await db.rawQuery(
    '''
    SELECT SUM(litres) AS total
    FROM fuel_logs
    WHERE userEmail = ?
    $condition
    ''',
    [currentUserEmail],
  );

  return (result.first['total'] as num?)?.toDouble() ?? 0.0;
}

static Future<double> getFilteredEmissions(String filter) async {
  final fuel = await getFilteredFuelUsed(filter);
  return fuel * 2.31;
}

static Future<int> getFilteredFuelEntries(String filter) async {
  final db = await database;

  String condition = '';

  switch (filter) {
    case 'Today':
      condition = "AND date = date('now','localtime')";
      break;

    case 'This Week':
      condition = "AND date >= date('now','-6 days')";
      break;

    case 'This Month':
      condition =
          "AND strftime('%Y-%m', date) = strftime('%Y-%m','now')";
      break;

    default:
      condition = '';
  }

  final result = await db.rawQuery(
    '''
    SELECT COUNT(*) AS total
    FROM fuel_logs
    WHERE userEmail = ?
    $condition
    ''',
    [currentUserEmail],
  );

  return (result.first['total'] as int?) ?? 0;
}

static Future<double> getSelectedVehicleFuelUsed() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT SUM(litres) AS total
    FROM fuel_logs
    WHERE vehicleName = ?
    AND userEmail = ?
    ''',
    [selectedVehicle, currentUserEmail],
  );

  return (result.first['total'] as num?)?.toDouble() ?? 0.0;
}
static Future<double> getSelectedVehicleEmissions() async {
  final fuel = await getSelectedVehicleFuelUsed();
  return fuel * 2.31;
}

static Future<int> getSelectedVehicleEntries() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT COUNT(*) AS total
    FROM fuel_logs
    WHERE vehicleName = ?
    AND userEmail = ?
    ''',
    [
      selectedVehicle,
      currentUserEmail,
    ],
  );

  return (result.first['total'] as int?) ?? 0;
}
// ==========================
// ANALYTICS
// ==========================

static Future<int> getFuelEntryCount() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT COUNT(*) AS total
    FROM fuel_logs
    WHERE userEmail = ?
    ''',
    [currentUserEmail],
  );

  return (result.first['total'] as int?) ?? 0;
}

static Future<double> getAverageFuelPerEntry() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT AVG(litres) AS average
    FROM fuel_logs
    WHERE userEmail = ?
    ''',
    [currentUserEmail],
  );

  return (result.first['average'] as num?)?.toDouble() ?? 0.0;
}
static Future<double> getHighestFuelRefill() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT MAX(litres) AS highest
    FROM fuel_logs
    WHERE userEmail = ?
    AND vehicleName = ?
    ''',
    [
      currentUserEmail,
      selectedVehicle,
    ],
  );

  return (result.first['highest'] as num?)?.toDouble() ?? 0.0;
}

static Future<double> getLowestFuelRefill() async {
  final db = await database;

  final result = await db.rawQuery(
    '''
    SELECT MIN(litres) AS lowest
    FROM fuel_logs
    WHERE userEmail = ?
    AND vehicleName = ?
    ''',
    [
      currentUserEmail,
      selectedVehicle,
    ],
  );

  return (result.first['lowest'] as num?)?.toDouble() ?? 0.0;
}

// ==========================
// PREDICTIONS
// ==========================

static Future<double> getPredictedMonthlyFuelUsage() async {
  final totalFuel = await getTotalFuelUsed();
  final entries = await getFuelEntryCount();

  if (entries == 0) return 0;

  // Average litres per refill × expected 8 refills/month
  final averagePerRefill = totalFuel / entries;

  return averagePerRefill * 8;
}

static Future<double> getPredictedMonthlyEmissions() async {
  final predictedFuel =
      await getPredictedMonthlyFuelUsage();

  return predictedFuel * 2.31;
}

// ==========================
// RECOMMENDATIONS
// ==========================

static Future<String> getRecommendation() async {

  double fuel = await getTotalFuelUsed();
  double emissions = await getTotalEmissions();
  int entries = await getFuelEntryCount();

  if (entries < 3) {
    return "Add more fuel entries to improve prediction accuracy.";
  }

  if (fuel > 100) {
    return "Your fuel usage is quite high. Consider smoother acceleration and reducing unnecessary trips.";
  }

  if (emissions > 200) {
    return "Your carbon emissions are increasing. Consider carpooling or regular servicing.";
  }

  return "Great job! Your fuel usage and emissions are within a healthy range. Keep maintaining efficient driving habits.";
}

static Future<String> getEfficiencyAdvice() async {

  double fuel = await getTotalFuelUsed();

  if (fuel > 100) {
    return "Schedule a vehicle service to improve fuel efficiency.";
  }

  return "Your vehicle appears to be operating efficiently.";
}

static Future<String> getEnvironmentalAdvice() async {

  double emissions = await getTotalEmissions();

  if (emissions > 200) {
    return "Reducing unnecessary journeys can significantly lower your emissions.";
  }

  return "Your environmental impact is currently moderate.";
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
  static Future<void> saveSelectedVehicle(String vehicleName) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'selectedVehicle',
    vehicleName,
  );

  selectedVehicle = vehicleName;
}

static Future<String?> loadSelectedVehicle() async {
  final prefs = await SharedPreferences.getInstance();

  selectedVehicle =
      prefs.getString('selectedVehicle');

  return selectedVehicle;
}
}