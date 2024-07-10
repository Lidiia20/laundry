import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/models/customer.dart';
import 'package:laundry_app/pages/customer/customer_helper.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({super.key});

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  // buat controller untuk textfield
  final nameCtrl = TextEditingController();

  final phoneCtrl = TextEditingController();

  final addresssCtrl = TextEditingController();

// buat key untuk form
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // dispose controller
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addresssCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value!.isEmpty) return 'Harap isi nama';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneCtrl,
                validator: (value) {
                  if (value!.isEmpty) return 'Harap isi nomor telepon';
                  if (!RegExp(r'^\d+$').hasMatch(value)) {
                    return 'Harap masukkan angka saja';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'No. Telp'),
                keyboardType: TextInputType.number, // hanya angka
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // hanya angka
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: addresssCtrl,
                validator: (value) {
                  if (value!.isEmpty) return 'Harap isi alamat';
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                  onPressed: () {
                    // jalankan fungsi _createCustomer() saat tombol ditekan
                    _createCustomer();
                  },
                  child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }

  void _createCustomer() async {
    // jika form tidak valid
    if (!formKey.currentState!.validate()) return;

    // buat customer
    final customer = CustomerModel(
      name: nameCtrl.text,
      phoneNumber: phoneCtrl.text,
      address: addresssCtrl.text,
      createdAt: DateTime.now(),
    );

    // tambahkan ke database
    insertCustomer(customer).then((value) {
      if (value >= 0) {
        // kembali ke halaman customer
        Navigator.pop(context);
        // tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer berhasil ditambahkan')),
        );
      } else {
        // tampilkan snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer gagal ditambahkan')),
        );
      }
    });
  }
}
