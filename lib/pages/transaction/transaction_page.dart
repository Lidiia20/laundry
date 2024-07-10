// transaction_page.dart

import 'package:flutter/material.dart';
import 'package:laundry_app/extensions/datetime_extension.dart';
import 'package:laundry_app/models/transaction.dart';
import 'package:laundry_app/pages/transaction/transaction_helper.dart';
import 'package:laundry_app/routes/route_names.dart';
import 'package:laundry_app/widgets/drawer/drawer_widget.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  List<TransactionModel> transactions = [];
  TransactionModel? selectedTransaction;

  @override
  void initState() {
    _getTransactions();
    super.initState();
  }

  void _getTransactions() async {
    final newTransaction = await getAllTransactions();
    setState(() {
      transactions = newTransaction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      drawer: const DrawerWidget(),
      body: transactions.isEmpty
          // jika data transaksi masih kosong maka akan menampilkan text ini
          ? const Center(
              child: Text('Tidak ada data Transaksi',
                  style: TextStyle(fontSize: 20)))
          :
          // jika sudah ada maka akan menampilkan list view builder

          ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final isSelected = selectedTransaction == transaction;
                return ListTile(
                  title: Text(transaction.customer?.name ?? ''),
                  onTap: () {
                    _onItemPressed(context, transaction);
                  },
                  selected: isSelected,
                  subtitle: Text(
                      'Pickup Date: ${transaction.pickupDate.formatDate()}'),
                  trailing: isSelected
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _onDeletePressed(context);
                          },
                        )
                      : null,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(RouteNames.addTransaction);
          _getTransactions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onItemPressed(
      BuildContext context, TransactionModel transaction) async {
    // jika sudah memilih customer maka akan menjalankan fungsi ini
    if (selectedTransaction == transaction) {
      // jika sudah memilih maka akan menuju halaman detail transaksi
      await Navigator.pushNamed(context, RouteNames.detailTransaction,
          arguments: transaction);
      // ketika kembali ke halaman transaksi, maka refresh data
      selectedTransaction = null;
      _getTransactions();
    } else {
      setState(() {
        selectedTransaction = transaction; // pilih customer yang dipilih
      });
    }
  }

  _onDeletePressed(BuildContext context) async {
    // jika tombol delete di klik maka akan menjalankan fungsi ini
    if (selectedTransaction != null) {
      // jika sudah memilih customer maka akan menjalankan fungsi ini
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Hapus Transaksi'),
              content: Text(
                  'Apa anda yakin ingin menghapus Transaksi oleh "${selectedTransaction!.customer?.name}" ini?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('No')),
                TextButton(
                    onPressed: () async {
                      // jika tombol yes di klik maka akan menjalankan fungsi ini
                      deleteTransaction(selectedTransaction!.id!).then((value) {
                        // jika berhasil menghapus customer maka akan menjalankan fungsi ini
                        if (value >= 1) {
                          // value bernilai >= 1 artinya berhasil menghapus customer
                          setState(() {});
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Transaksi" berhasil dihapus')));
                          selectedTransaction =
                              null; //kosongkan customer yang dipilih
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Transaksi" gagal dihapus')));
                        }
                      });
                    },
                    child: const Text('Yes')),
              ],
            );
          });
    }
    _getTransactions(); //refresh data
  }
}
