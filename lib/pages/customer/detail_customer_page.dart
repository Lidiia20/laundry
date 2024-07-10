import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laundry_app/models/customer.dart';
import 'package:laundry_app/pages/customer/customer_helper.dart';

class DetailCustomerPage extends StatefulWidget {
  const DetailCustomerPage({super.key, required this.customer});

  final CustomerModel customer;

  @override
  State<DetailCustomerPage> createState() => _DetailCustomerPageState();
}

class _DetailCustomerPageState extends State<DetailCustomerPage> {
  // buat controller untuk textfield
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addresssCtrl = TextEditingController();

// buat key untuk form
  final formKey = GlobalKey<FormState>();

  // buat variabel untuk menyimpan data customer terakhir
  CustomerModel? lastCustomer;

  // buat getter untuk mengambil data dari customer ygdi update
  CustomerModel get customer => lastCustomer ?? widget.customer;

// buat state untuk menampung apakah sedang diedit atau tidak
  bool isEditing = false;

  @override
  void initState() {
    lastCustomer = customer; // inisialisasi state dengan data dari widget
    _assignCustomerToTextField(); // panggil fungsi untuk mengisi textfield dengan data customer
    super.initState();
  }

  @override
  void dispose() {
    // dispose controller
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addresssCtrl.dispose();
    super.dispose();
  }

  // buat fungsi untuk mengambil data dari customer dan assign ke textfield
  void _assignCustomerToTextField() {
    nameCtrl.text = customer.name;
    phoneCtrl.text = customer.phoneNumber;
    addresssCtrl.text = customer.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${isEditing ? "Edit : " : ""} ${customer.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                readOnly: !isEditing, // hanya bisa diedit jika isEditing = true
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value!.isEmpty) return 'Harap isi nama';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneCtrl,
                readOnly: !isEditing, // hanya bisa diedit jika isEditing = true
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
                readOnly: !isEditing, // hanya bisa diedit jika isEditing = true
                validator: (value) {
                  if (value!.isEmpty) return 'Harap isi alamat';
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Alamat'),
              ),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                FilledButton(
                    onPressed: () {
                      if (isEditing) {
                        _updateCustomer();
                      }
                      _toogleEditing();
                    },
                    child: Text(isEditing ? 'Simpan' : 'Edit')),
                isEditing
                    ? FilledButton(
                        onPressed: () {
                          _toogleEditing();
                          _assignCustomerToTextField();
                        },
                        child: const Text('Batal'))
                    : Container()
              ]),
            ],
          ),
        ),
      ),
    );
  }

  void _toogleEditing() {
    // buat fungsi untuk mengubah state isEditing
    setState(() => isEditing = !isEditing);
  }

  void _updateCustomer() async {
    // jika form tidak valid
    if (!formKey.currentState!.validate()) return;

    // buat customer
    final newCustomer = CustomerModel(
      id: customer.id,
      name: nameCtrl.text,
      phoneNumber: phoneCtrl.text,
      address: addresssCtrl.text,
      createdAt: DateTime.now(),
    );

    // tambahkan ke database
    updateCustomer(newCustomer).then((value) {
      if (value > 0) {
        lastCustomer = newCustomer;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Customer berhasil diperbarui')),
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
