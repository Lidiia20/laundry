import 'package:flutter/material.dart';
import 'package:laundry_app/database/db_helper.dart';
import 'package:laundry_app/routes/app_routes.dart';

void main() async {
  // memastikan bahwa binding dari Flutter telah diinisialisasi dengan benar sebelum, menjalankan kode yang memerlukan akses ke widget atau rendering.
  WidgetsFlutterBinding.ensureInitialized();

  // initialize database, database akan dibuat jika belum ada, proses ini sebaiknya dilakukan pada saat aplikasi pertama kali dijalankan dan di tunggu sampai selesai, baru memanggil fungsi main()
  await DBHelper.instance.initDatabase();
  // jalankan aplikasi
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Laundry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes:
          AppRoutes.generated, // Gantilah dengan halaman utama aplikasi Anda
    );
  }
}
