import 'dart:developer';

import 'package:laundry_app/database/db_helper.dart';
import 'package:laundry_app/database/query/transaction_query.dart';
import 'package:laundry_app/models/transaction.dart';

Future<List<TransactionModel>> getPickupByDate(DateTime date) async {
  final db = await DBHelper.instance.database;
  final query = await db.rawQuery(
      TransactionQuery.selectTransactionByPickUpDateWithCustomer(
          date, date.add(const Duration(days: 1))));
  final List<TransactionModel> transactions = [];
  for (final item in query) {
    transactions.add(TransactionModel.fromJsonWithCustomer(item));
  }
  log("transactions ${transactions.length}}", name: "getPickupByDate");
  return transactions;
}
