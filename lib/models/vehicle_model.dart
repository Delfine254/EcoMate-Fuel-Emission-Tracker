class Vehicle {
  int? id;
  String name;
  String fuelType;
  double efficiency;

  Vehicle({
    this.id,
    required this.name,
    required this.fuelType,
    required this.efficiency,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'fuelType': fuelType,
      'efficiency': efficiency,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      name: map['name'],
      fuelType: map['fuelType'],
      efficiency: map['efficiency'],
    );
  }
}