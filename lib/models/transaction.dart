import 'package:equatable/equatable.dart';
import 'package:laundry_app/models/customer.dart';

class TransactionModel extends Equatable {
  final int? id;
  final int customerId;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final String status;
  final int totalPrice;
  final String serviceType;
  final DateTime createdAt;
  final CustomerModel? customer;

  const TransactionModel(
      {this.id,
      required this.customerId,
      required this.pickupDate,
      required this.deliveryDate,
      required this.status,
      required this.totalPrice,
      required this.serviceType,
      required this.createdAt,
      this.customer});

  // Method to convert Transaction object to a Map object
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'customer_id': customerId,
      'pickup_date': pickupDate.toIso8601String(),
      'delivery_date': deliveryDate.toIso8601String(),
      'status': status,
      'total_price': totalPrice,
      'service_type': serviceType,
      'created_at': createdAt.toIso8601String(),
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['id'],
        customerId: map['customer_id'],
        pickupDate: DateTime.parse(map['pickup_date']),
        deliveryDate: DateTime.parse(map['delivery_date']),
        status: map['status'],
        totalPrice: map['total_price'],
        serviceType: map['service_type'],
        createdAt: DateTime.parse(map['created_at']));
  }

  factory TransactionModel.fromJsonWithCustomer(Map<String, dynamic> map) {
    return TransactionModel(
        id: map['id'],
        customerId: map['customer_id'],
        pickupDate: DateTime.parse(map['pickup_date']),
        deliveryDate: DateTime.parse(map['delivery_date']),
        status: map['status'],
        totalPrice: map['total_price'],
        serviceType: map['service_type'],
        createdAt: DateTime.parse(map['created_at']),
        customer: CustomerModel(
            id: map["customer_id"],
            name: map["customer_name"],
            phoneNumber: map["customer_phone_number"],
            address: map["customer_address"],
            createdAt: DateTime.now()));
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        pickupDate,
        deliveryDate,
        status,
        totalPrice,
        serviceType,
        createdAt
      ];
}
