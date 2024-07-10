import 'dart:developer';

import 'package:laundry_app/database/query/customer_query.dart';
import 'package:laundry_app/database/query/transaction_query.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  // set nama database
  static const String dbName = "laundry_app.db";

  // buat instance dari database dengan private constructor
  static Database? _database;
  static final DBHelper instance = DBHelper._privateConstructor();
  DBHelper._privateConstructor();

  // fungsi untuk membuka database
  // jika sudah terbuka maka akan mengembalikan instance dari database
  // jika belum terbuka maka akan membuka database dan kemudian mengembalikan instance dari database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  // fungsi untuk membuka database
  // jika database belum ada maka akan membuat database baru
  // jika sudah ada maka akan mengembalikan instance dari database
  Future<Database> initDatabase() async {
    // cari lokasi database dgn path yg diberikan oleh sqflite
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path,
        version: 1,
        onCreate:
            _createDB); // perintah onCreate akan dijalankan jika database belum ada
  }

  Future<void> _createDB(Database db, int version) async {
    // query table untuk membuat tabel baru
    final tables = [
      CustomerQuery.createTable(),
      TransactionQuery.createTable()
    ];
    // jalankan semua query
    await Future.forEach(tables, (String table) {
      try {
        db.execute(table);
      } catch (e) {
        log("Error creating table: $e");
      }
    });
  }
}
