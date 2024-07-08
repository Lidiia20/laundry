// transaction_page.dart

import 'package:flutter/material.dart';
import 'package:laundry_app/models/transaction.dart';
import 'package:laundry_app/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    // Contoh untuk menambah transaksi
    void addNewTransaction() {
      final newTransaction = TransactionModel(
        id: DateTime.now()
            .millisecondsSinceEpoch, // Gunakan ID yang unik, bisa menggunakan timestamp
        customerName:
            'John Doe', // Ganti dengan data dari form atau input pengguna
        pickupDate:
            '2024-07-08', // Ganti dengan data dari form atau input pengguna
        deliveryDate:
            '2024-07-10', // Ganti dengan data dari form atau input pengguna
        status: 'Pending', // Ganti dengan data dari form atau input pengguna
      );
      transactionProvider.addTransaction(newTransaction);
    }

    // Contoh untuk mengubah transaksi
    void updateExistingTransaction() {
      final updatedTransaction = TransactionModel(
        id: 1, // ID transaksi yang ingin diubah
        customerName:
            'Updated Customer Name', // Ganti dengan data baru dari form atau input pengguna
        pickupDate:
            '2024-07-09', // Ganti dengan data baru dari form atau input pengguna
        deliveryDate:
            '2024-07-11', // Ganti dengan data baru dari form atau input pengguna
        status:
            'Completed', // Ganti dengan data baru dari form atau input pengguna
      );
      transactionProvider.updateTransaction(updatedTransaction);
    }

    // Contoh untuk menghapus transaksi
    void deleteExistingTransaction() {
      const transactionIdToDelete =
          1; // Ganti dengan ID transaksi yang ingin dihapus
      transactionProvider.deleteTransaction(transactionIdToDelete);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: ListView.builder(
        itemCount: transactionProvider.transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactionProvider.transactions[index];
          return ListTile(
            title: Text(transaction.customerName),
            subtitle: Text('Pickup Date: ${transaction.pickupDate}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                transactionProvider.deleteTransaction(transaction.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            addNewTransaction, // Ganti dengan fungsi untuk menampilkan form tambah transaksi
        child: const Icon(Icons.add),
      ),
    );
  }
}
