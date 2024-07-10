// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:laundry_app/pages/customer/customer_helper.dart';
import 'package:laundry_app/routes/route_names.dart';
import 'package:laundry_app/widgets/drawer/drawer_widget.dart';

import '../../models/customer.dart';

class CustomerPage extends StatefulWidget {
  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  // variable untuk nampung data customer
  List<CustomerModel> customers = [];

  // variable untuk nampung data customer yang sedang dipilih
  CustomerModel? selectedCustomer;

  @override
  void initState() {
    // saat widget dibuat, akan menjalankan fungsi ini
    _getCustomers(); // mengambil data dari database
    super.initState();
  }

  void _getCustomers() {
    getCustomers().then((value) {
      setState(() {
        customers = value; // set state untuk mengupdate data customer
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      drawer: DrawerWidget(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: customers.isEmpty
              // jika data customer masih kosong maka akan menampilkan text ini
              ? Center(
                  child: Text('Tidak ada data customer',
                      style: TextStyle(fontSize: 20)))
              :
              // jika sudah ada maka akan menampilkan list view builder
              ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    CustomerModel customer = customers[index];
                    final isSelected = selectedCustomer == customer;
                    return ListTile(
                      title: Text(customer.name),
                      subtitle: Text(customer.phoneNumber),
                      onTap: () => _onItemPressed(context, customer),
                      selected: isSelected,
                      trailing: isSelected
                          ? IconButton(
                              onPressed: () {
                                _onDeletePressed(context);
                              },
                              icon: Icon(Icons.delete))
                          : null,
                    );
                  },
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // menuju halaman tambah customer
          await Navigator.pushNamed(context, RouteNames.addCustomer);
          // ketika kembali ke halaman customer, maka refresh data
          _getCustomers();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _onItemPressed(BuildContext context, CustomerModel customer) async {
    // jika sudah memilih customer maka akan menjalankan fungsi ini
    if (selectedCustomer == customer) {
      // jika sudah memilih maka akan menuju halaman detail customer
      await Navigator.pushNamed(context, RouteNames.detailCustomer,
          arguments: customer);
      // ketika kembali ke halaman customer, maka refresh data
      selectedCustomer = null;
      _getCustomers();
    } else {
      setState(() {
        selectedCustomer = customer; // pilih customer yang dipilih
      });
    }
  }

  _onDeletePressed(BuildContext context) async {
    // jika tombol delete di klik maka akan menjalankan fungsi ini
    if (selectedCustomer != null) {
      // jika sudah memilih customer maka akan menjalankan fungsi ini
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Hapus Customer'),
              content: Text(
                  'Apa anda yakin ingin menghapus customer "${selectedCustomer!.name}" ini?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('No')),
                TextButton(
                    onPressed: () async {
                      // jika tombol yes di klik maka akan menjalankan fungsi ini
                      deleteCustomer(selectedCustomer!.id!).then((value) {
                        // jika berhasil menghapus customer maka akan menjalankan fungsi ini
                        if (value >= 1) {
                          // value bernilai >= 1 artinya berhasil menghapus customer
                          setState(() {});
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Customer "${selectedCustomer!.name}" berhasil dihapus')));
                          selectedCustomer =
                              null; //kosongkan customer yang dipilih
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Customer "${selectedCustomer!.name}" gagal dihapus')));
                        }
                      });
                    },
                    child: Text('Yes')),
              ],
            );
          });
    }
    _getCustomers(); //refresh data
  }
}
