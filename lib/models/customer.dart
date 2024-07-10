// lib/models/customer.dart
import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  final int? id;
  final String name;
  final String phoneNumber;
  final String address;
  final DateTime createdAt;

  const CustomerModel({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        createdAt: DateTime.parse(json['created_at']),
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'name': name,
      'phone_number': phoneNumber,
      'address': address,
      'created_at': createdAt.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  @override
  List<Object?> get props => [name, phoneNumber, address, id, createdAt];
}
