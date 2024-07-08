// transaction.dart

class TransactionModel {
  final int id;
  final String customerName;
  final String pickupDate;
  final String deliveryDate;
  final String status;

  TransactionModel({
    required this.id,
    required this.customerName,
    required this.pickupDate,
    required this.deliveryDate,
    required this.status,
  });

  // Method to convert Transaction object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'pickupDate': pickupDate,
      'deliveryDate': deliveryDate,
      'status': status,
    };
  }
}
