import 'dart:developer';

import 'package:laundry_app/database/db_helper.dart';
import 'package:laundry_app/database/query/transaction_query.dart';
import 'package:laundry_app/models/transaction.dart';

Future<List<TransactionModel>> getAllTransactions() async {
  final db = await DBHelper.instance.database;
  final query = await db.rawQuery(TransactionQuery.selectAllWithCustomer());
  log('getAllTransactions: $query');
  return query.map((e) => TransactionModel.fromJsonWithCustomer(e)).toList();
}

Future<int> insertTransaction(TransactionModel transaction) async {
  final db = await DBHelper.instance.database;
  final result =
      await db.insert(TransactionQuery.tableName, transaction.toMap());
  log('insertTransaction: $result');
  return result;
}

Future<int> deleteTransaction(int id) async {
  final db = await DBHelper.instance.database;
  final result = await db
      .delete(TransactionQuery.tableName, where: 'id = ?', whereArgs: [id]);
  return result;
}

Future updateTransaction(TransactionModel transaction) async {
  final db = await DBHelper.instance.database;
  final result = await db.update(
      TransactionQuery.tableName, transaction.toMap(),
      where: 'id = ?', whereArgs: [transaction.id]);
  return result;
}

Future<int> selectByDate(DateTime date) async {
  final db = await DBHelper.instance.database;
  final query =
      await db.rawQuery(TransactionQuery.selectTransactionByDate(date));
  log('getAllTransactions: $query');
  return query.length;
}
