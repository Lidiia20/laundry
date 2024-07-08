// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, use_super_parameters, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import untuk ChangeNotifierProvider
import 'package:laundry_app/providers/customer_provider.dart'; // Sesuaikan dengan lokasi CustomerProvider.dart Anda
import '../pages/customer_page.dart'; // Sesuaikan dengan lokasi CustomerPage
import '../providers/transaction_provider.dart';
import '../pages/transaction_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomerProvider>(
      create: (context) => CustomerProvider(), // Sesuaikan dengan konstruktor CustomerProvider Anda
      child: MaterialApp(
        title: 'Laundry App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LaundryHomePage(), // Gantilah dengan halaman utama aplikasi Anda
      ),
    );
  }
}

class LaundryHomePage extends StatelessWidget {
  const LaundryHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaundryKlin'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Beranda'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Tambahkan aksi ketika menu beranda dipilih
              },
            ),
            ListTile(
              title: const Text('Pickup'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Tambahkan aksi ketika menu pickup dipilih
              },
            ),
            ListTile(
              title: const Text('Customer'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerPage()), // Navigasi ke halaman CustomerPage
                );
              },
            ),
            ListTile(
              title: const Text('Pesanan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Tambahkan aksi ketika menu pesanan dipilih
              },
            ),
            ListTile(
              title: const Text('Pengaturan'),
              onTap: () {
                Navigator.pop(context); // Tutup drawer
                // Tambahkan aksi ketika menu pengaturan dipilih
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Selamat datang di LaundryKlin!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan navigasi ke halaman selanjutnya di sini
              },
              child: const Text('Mulai'),
            ),
          ],
        ),
      ),
    );
  }
}
