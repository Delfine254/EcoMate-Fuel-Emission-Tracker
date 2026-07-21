class FuelLog {
  int? id;
  String userEmail;
  String vehicleName;
  double litres;
  double odometer;
  String date;

  FuelLog({
    this.id,
    required this.userEmail,
    required this.vehicleName,
    required this.litres,
    required this.odometer,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'vehicleName': vehicleName,
      'litres': litres,
      'odometer': odometer,
      'date': date,
    };
  }

  factory FuelLog.fromMap(Map<String, dynamic> map) {
    return FuelLog(
      id: map['id'],
      userEmail: map['userEmail'],
      vehicleName: map['vehicleName'],
      litres: map['litres'],
      odometer: map['odometer'],
      date: map['date'],
    );
  }
}