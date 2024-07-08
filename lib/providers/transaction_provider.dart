// transaction_provider.dart

import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  DBHelper dbHelper = DBHelper.instance;

  List<TransactionModel> get transactions => [..._transactions];

  Future<void> fetchTransactions() async {
    final fetchedTransactions = await dbHelper.getTransactions();
    _transactions = fetchedTransactions;
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await dbHelper.insertTransaction(transaction);
    await fetchTransactions();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await dbHelper.updateTransaction(transaction);
    await fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await dbHelper.deleteTransaction(id);
    await fetchTransactions();
  }
}
