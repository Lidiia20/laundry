import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/extensions/datetime_extension.dart';
import 'package:laundry_app/models/customer.dart';
import 'package:laundry_app/models/transaction.dart';
import 'package:laundry_app/pages/customer/customer_helper.dart';
import 'package:laundry_app/pages/transaction/transaction_helper.dart';

class DetailTransactionPage extends StatefulWidget {
  const DetailTransactionPage({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  State<DetailTransactionPage> createState() => _DetailTransactionPageState();
}

class _DetailTransactionPageState extends State<DetailTransactionPage> {
  TransactionModel? lastTransaction;
  TransactionModel get transaction => lastTransaction ?? widget.transaction;

  bool isEditing = false;

  // buat controller untuk textfield
  CustomerModel? customerCtrl;
  DateTime? pickupDate;
  DateTime? deliveryDate;
  final statusCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final serviceCtrl = TextEditingController();
  DateTime createdAt = DateTime.now();

// buat key untuk form
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // dispose controller
    statusCtrl.dispose();
    priceCtrl.dispose();
    serviceCtrl.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // assign transaction ke controller
    _assignTransactionToField();
    super.initState();
  }

  void _assignTransactionToField() {
    customerCtrl = transaction.customer!;
    pickupDate = transaction.pickupDate;
    deliveryDate = transaction.deliveryDate;
    statusCtrl.text = transaction.status;
    priceCtrl.text = transaction.totalPrice.toString();
    serviceCtrl.text = transaction.serviceType;
    createdAt = transaction.createdAt;
  }

  @override
  Widget build(BuildContext delivery) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${isEditing ? "Edit " : "Detail "} Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Autocomplete<CustomerModel>(
                  optionsBuilder: _optionsBuilder,
                  onSelected: (value) {
                    customerCtrl = value;
                  },
                  initialValue: TextEditingValue(text: '${customerCtrl?.name}'),
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    if (customerCtrl?.name != textEditingController.text) {
                      customerCtrl = null;
                    }
                    return TextFormField(
                      controller: textEditingController,
                      readOnly:
                          !isEditing, // hanya bisa diedit jika isEditing = tru
                      focusNode: focusNode,
                      decoration:
                          const InputDecoration(labelText: 'Nama Customer'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harap isi nama customer';
                        }
                        return null;
                      },
                    );
                  },
                  displayStringForOption: (CustomerModel option) => option.name,
                ),
                TextFormField(
                  controller: statusCtrl,
                  readOnly:
                      !isEditing, // hanya bisa diedit jika isEditing = tru
                  decoration: const InputDecoration(labelText: 'Status'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Harap isi status traksaksi';
                    return null;
                  },
                ),
                Row(
                  children: [
                    const Text("Tanggal Pickup"),
                    Expanded(
                        child: TextButton(
                      onPressed: !isEditing
                          ? null
                          : () async {
                              final DateTime? picked = await showDatePicker(
                                  context: delivery,
                                  initialDate: pickupDate ?? DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != pickupDate) {
                                setState(() {
                                  pickupDate = picked;
                                });
                              }
                            },
                      child: Text(pickupDate == null
                          ? "Pilih Tanggal"
                          : pickupDate!.formatDate()),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Tanggal Delivery"),
                    Expanded(
                        child: TextButton(
                      onPressed: !isEditing
                          ? null
                          : () async {
                              final DateTime? picked = await showDatePicker(
                                  context: delivery,
                                  initialDate: deliveryDate ?? DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != pickupDate) {
                                setState(() {
                                  deliveryDate = picked;
                                });
                              }
                            },
                      child: Text(deliveryDate == null
                          ? "Pilih Tanggal"
                          : deliveryDate!.formatDate()),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: priceCtrl,
                  readOnly:
                      !isEditing, // hanya bisa diedit jika isEditing = tru
                  validator: (value) {
                    if (value!.isEmpty) return 'Harap isi total harga';
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Harap masukkan angka saja';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Total Harga', prefix: Text("Rp")),
                  keyboardType: TextInputType.number, // hanya angka
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // hanya angka
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: serviceCtrl,
                  readOnly:
                      !isEditing, // hanya bisa diedit jika isEditing = tru
                  validator: (value) {
                    if (value!.isEmpty) return 'Harap isi tipe layanan';
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Tipe Layanan'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text("Tanggal Transaksi"),
                    Expanded(
                        child: TextButton(
                      onPressed: !isEditing
                          ? null
                          : () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: pickupDate ?? DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime(2101));
                              if (picked != null && picked != pickupDate) {
                                setState(() {
                                  pickupDate = picked;
                                });
                              }
                            },
                      child: Text(createdAt.formatDate()),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton(
                          onPressed: () {
                            if (isEditing) {
                              _updateTransaction();
                            }
                            _toogleEditing();
                          },
                          child: Text(isEditing ? 'Simpan' : 'Edit')),
                      isEditing
                          ? FilledButton(
                              onPressed: () {
                                _toogleEditing();
                                _assignTransactionToField();
                              },
                              child: const Text('Batal'))
                          : Container()
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toogleEditing() {
    setState(() => isEditing = !isEditing);
  }

  void _updateTransaction() async {
    // jika form tidak valid
    if (!formKey.currentState!.validate() ||
        customerCtrl == null ||
        pickupDate == null ||
        deliveryDate == null) {
      return;
    }

    // buat transaksi baru
    final newTransaction = TransactionModel(
      id: transaction.id ?? 0,
      customerId: customerCtrl!.id!,
      status: statusCtrl.text,
      totalPrice: int.parse(priceCtrl.text),
      serviceType: serviceCtrl.text,
      pickupDate: pickupDate!,
      deliveryDate: deliveryDate!,
      createdAt: createdAt,
    );

    // tambahkan ke database
    updateTransaction(newTransaction).then((value) {
      if (value >= 1) {
        // kembali ke halaman customer
        Navigator.pop(context);
        // tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaksi berhasil diperbarui')),
        );
      } else {
        // tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaksi gagal diperbarui')),
        );
      }
    });
  }

  FutureOr<Iterable<CustomerModel>> _optionsBuilder(
      TextEditingValue textEditingValue) async {
    if (textEditingValue.text == '') {
      customerCtrl = null;
      return [];
    }
    // ambil data customer dari database
    final value = textEditingValue.text.toLowerCase();
    final customers = await getCustomersByNameOrId(value);
    return customers;
  }
}
