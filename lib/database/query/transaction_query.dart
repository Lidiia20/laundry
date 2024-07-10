class TransactionQuery {
  static const tableName = "transactions";
  static const idColumn = "id";
  static const customerIdColumn = "customer_id";
  static const pickupDateColumn = "pickup_date";
  static const deliveryDateColumn = "delivery_date";
  static const statusColumn = "status";
  static const totalPriceColumn = "total_price";
  static const serviceTypeColumn = "service_type";
  static const createdAtColumn = "created_at";

  // method untuk membuat tabel
  static String createTable() {
    return '''
CREATE TABLE $tableName (
  $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
  $customerIdColumn INTEGER NOT NULL,
  $pickupDateColumn TEXT NOT NULL,
  $deliveryDateColumn TEXT NOT NULL,
  $statusColumn TEXT NOT NULL,
  $totalPriceColumn INTEGER NOT NULL,
  $serviceTypeColumn TEXT NOT NULL,
  $createdAtColumn DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ($customerIdColumn) REFERENCES customers($idColumn)
)
''';
  }

  // method untuk mengambil semua data dari tabel
  static String selectAll() {
    return "SELECT * FROM $tableName";
  }

  static String selectAllWithCustomer() {
    return '''
      SELECT transactions.*, customers.name AS customer_name, customers.phone_number AS customer_phone_number, customers.address AS customer_address FROM $tableName
      LEFT JOIN customers ON $customerIdColumn = customers.$idColumn
    ''';
  }

  // method untuk mengambil data berdasarkan id
  static String selectById(int id) {
    return "SELECT * FROM $tableName WHERE $idColumn = ?";
  }

  // method untuk menambah data
  static String insert(int customerId, String pickupDate, String deliveryDate,
      String status, int totalPrice, String serviceType) {
    return "INSERT INTO $tableName ($customerIdColumn, $pickupDateColumn, $deliveryDateColumn, $statusColumn, $totalPriceColumn, $serviceTypeColumn, $createdAtColumn) VALUES($customerId, '$pickupDate', '$deliveryDate', '$status', $totalPrice, '$serviceType', datetime('now'))";
  }

  // method untuk mengubah data
  static String update(int id, int customerId, String pickupDate,
      String deliveryDate, String status, int totalPrice, String serviceType) {
    return "UPDATE $tableName SET $customerIdColumn=$customerId, $pickupDateColumn='$pickupDate', $deliveryDateColumn='$deliveryDate', $statusColumn='$status', $totalPriceColumn=$totalPrice, $serviceTypeColumn='$serviceType' WHERE $idColumn=$id";
  }

  // method untuk menghapus data
  static String delete(int id) {
    return "DELETE FROM $tableName WHERE $idColumn=$id";
  }

// Hanya untuk menampilkan transaksi 7 hari terakhir
  static String selectTransactionByDate(DateTime date) {
    return '''
SELECT * FROM $tableName WHERE $createdAtColumn BETWEEN datetime('now', '-7 days') AND datetime('now')
''';
  }
}
