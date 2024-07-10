import 'package:flutter/material.dart';
import 'package:laundry_app/pages/transaction/transaction_helper.dart';
import 'package:laundry_app/routes/route_names.dart';
import 'package:laundry_app/widgets/drawer/drawer_widget.dart';

class LaundryHomePage extends StatelessWidget {
  const LaundryHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LaundryKlin'),
      ),
      drawer: const DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Selamat datang di LaundryKlin!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              const Text(
                'Kelola bisnis laundry Anda dengan mudah dan efisien'
                'Aplikasi ini membantu Anda dalam mencatat transaksi, '
                'mengelola pelanggan, dan memantau status laundry.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.transaction);
                },
                child: Container(
                  color: Colors.indigoAccent,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          FutureBuilder(
                              future: selectByDate(DateTime.now()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                      "Jumlah Transaksi hari ini ada ${snapshot.data}",
                                      style: const TextStyle(
                                          fontSize: 24, color: Colors.white));
                                }
                                return const CircularProgressIndicator();
                              }),
                          const SizedBox(height: 40),
                          const Text(
                            "tap untuk lihat transaksi lebih lengkap",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.customer);
                },
                child: Container(
                  color: Colors.indigoAccent,
                  padding: const EdgeInsets.all(15),
                  child: const Row(
                    children: [
                      Column(
                        children: [
                          Text("Jumlah Customer baru hari ini ada XX",
                              overflow: TextOverflow.fade,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          SizedBox(height: 40),
                          Text(
                            "tap untuk lihat data customer lebih lengkap",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
