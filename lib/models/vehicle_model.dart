class Vehicle {
  int? id;
  String userEmail;
  String name;
  String fuelType;
  double efficiency;

  Vehicle({
    this.id,
    required this.userEmail,
    required this.name,
    required this.fuelType,
    required this.efficiency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userEmail': userEmail,
      'name': name,
      'fuelType': fuelType,
      'efficiency': efficiency,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      userEmail: map['userEmail'],
      name: map['name'],
      fuelType: map['fuelType'],
      efficiency: map['efficiency'],
    );
  }
}