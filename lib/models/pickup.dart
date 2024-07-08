// lib/models/pickup.dart
class Pickup {
  final int? id;
  final String customerName;
  final String serviceType;
  final double totalPrice;
  final DateTime pickupDate;

  Pickup({
    this.id,
    required this.customerName,
    required this.serviceType,
    required this.totalPrice,
    required this.pickupDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'serviceType': serviceType,
      'totalPrice': totalPrice,
      'pickupDate': pickupDate.toIso8601String(),
    };
  }

  factory Pickup.fromMap(Map<String, dynamic> map) {
    return Pickup(
      id: map['id'],
      customerName: map['customerName'],
      serviceType: map['serviceType'],
      totalPrice: map['totalPrice'],
      pickupDate: DateTime.parse(map['pickupDate']),
    );
  }
}
