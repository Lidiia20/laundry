import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/pickup.dart';
import '../models/transaction.dart';

class DBHelper {
  static Database? _database;
  static final DBHelper instance = DBHelper._privateConstructor();

  DBHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'laundry_app.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pickups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customerName TEXT,
        serviceType TEXT,
        totalPrice REAL,
        pickupDate TEXT
      )
    ''');
  }

  Future<List<Pickup>> fetchPickups() async {
    Database db = await instance.database;
    var pickups = await db.query('pickups', orderBy: 'pickupDate');
    List<Pickup> pickupList = pickups.isNotEmpty
        ? pickups.map((c) => Pickup.fromMap(c)).toList()
        : [];
    return pickupList;
  }

  Future<int> insertPickup(Pickup pickup) async {
    Database db = await instance.database;
    return await db.insert('pickups', pickup.toMap());
  }

  Future<int> updatePickup(Pickup pickup) async {
    Database db = await instance.database;
    return await db.update(
      'pickups',
      pickup.toMap(),
      where: 'id = ?',
      whereArgs: [pickup.id],
    );
  }

  Future<int> deletePickup(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'pickups',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY,
        customerName TEXT,
        pickupDate TEXT,
        deliveryDate TEXT,
        status TEXT
      )
    ''');
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    Database db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionModel>> getTransactions() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return TransactionModel(
        id: maps[i]['id'],
        customerName: maps[i]['customerName'],
        pickupDate: maps[i]['pickupDate'],
        deliveryDate: maps[i]['deliveryDate'],
        status: maps[i]['status'],
      );
    });
  }

  Future<int> updateTransaction(TransactionModel transaction) async {
    Database db = await instance.database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
