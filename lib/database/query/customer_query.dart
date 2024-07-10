/// kelas statik untuk berinteraksi dengan tabel dan kolom dalam database.
/// Ini memiliki konstanta nama tabel dan kolom, serta metode untuk membuat tabel.
/// kelas ini juga menyediakan method query untuk melakukan query CRUD pada database.
class CustomerQuery {
  static const tableName = "customers";
  static const idColumn = "id";
  static const nameColumn = "name";
  static const addressColumn = "address";
  static const phoneNumberColumn = "phone_number";
  static const createdAt = "created_at";

  // method untuk membuat tabel
  static String createTable() {
    return '''
CREATE TABLE $tableName (
  $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
  $nameColumn TEXT NOT NULL,
  $addressColumn TEXT NOT NULL,
  $phoneNumberColumn TEXT NOT NULL,
  $createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
)
''';
  }

  // method untuk mengambil semua data dari tabel
  static String selectAll() {
    return "SELECT * FROM $tableName";
  }

  // method untuk mengambil data berdasarkan id
  static String selectById(int id) {
    return "SELECT * FROM $tableName WHERE $idColumn = ?";
  }

  static String selectByIdOrName() {
    return "SELECT * FROM $tableName WHERE ($nameColumn LIKE ? OR $idColumn = ?)";
  }

  // method untuk menambah data
  static String insert(String name, String address, String phoneNumber) {
    return "INSERT INTO $tableName ($nameColumn,$addressColumn,$phoneNumberColumn, $createdAt) VALUES('$name','$address','$phoneNumber', datetime('now'))";
  }

// method untuk mengubah data
  static String update(
      int id, String name, String address, String phoneNumber) {
    return "UPDATE $tableName SET $nameColumn='$name',$addressColumn='$address',$phoneNumberColumn='$phoneNumber' WHERE $idColumn=$id";
  }

  // method untuk menghapus data
  static String delete(int id) {
    return "DELETE FROM $tableName WHERE $idColumn=$id";
  }

  static String selectByCreatedAt() {
    return "SELECT * FROM $tableName ORDER BY $createdAt";
  }
}
