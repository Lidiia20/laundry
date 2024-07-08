// transaction_provider.dart

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../database/db_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  DBHelper dbHelper = DBHelper.instance;

  List<Transaction> get transactions => [..._transactions];

  Future<void> fetchTransactions() async {
    final fetchedTransactions = await dbHelper.getTransactions();
    _transactions = fetchedTransactions;
    notifyListeners();
  }

  Future<void> addTransaction(Transaction transaction) async {
    await dbHelper.insertTransaction(transaction);
    await fetchTransactions();
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await dbHelper.updateTransaction(transaction);
    await fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    await dbHelper.deleteTransaction(id);
    await fetchTransactions();
  }
}
