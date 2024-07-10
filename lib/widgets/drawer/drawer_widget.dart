import 'package:flutter/material.dart';
import 'package:laundry_app/routes/route_names.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          // Menambahkan item-item drawer
          ..._buildDrawerItems(context),
        ],
      ),
    );
  }

  // Metode untuk membangun daftar item drawer dengan navigasi yang sesuai
  List<Widget> _buildDrawerItems(BuildContext context) {
    return [
      // Membuat item drawer untuk "Beranda"
      _createDrawerItem(context, 'Beranda', RouteNames.home),
      // Membuat item drawer untuk "Pickup"
      _createDrawerItem(context, 'Customer', RouteNames.customer),
      // Membuat item drawer untuk "Transaksi"
      _createDrawerItem(context, 'Transaksi', RouteNames.transaction),
      // Membuat item drawer untuk "PickUp"
      _createDrawerItem(context, "Pickup", RouteNames.pickup)
    ];
  }

  // Metode untuk membuat widget ListTile sebagai item drawer
  Widget _createDrawerItem(BuildContext context, String title, String route) {
    // jika route yang diberikan sama dengan route saat ini maka simpan nilai true
    final isSelected = ModalRoute.of(context)?.settings.name == route;
    return ListTile(
      // Mengatur warna background jika route yang diberikan sama dengan route saat ini
      selected: isSelected,
      title: Text(title),
      // jika route yang diberikan sama dengan route saat ini maka tampilkan icon check
      leading: isSelected ? const Icon(Icons.check) : null,
      // jika route yang diberikan sama dengan route saat ini maka tidak bisa ditekan
      onTap: isSelected
          ? null
          : () {
              Navigator.of(context).pop(); //menutup drawer
              Navigator.of(context)
                  .pushNamed(route); //pergi ke route yang diberikan
            },
    );
  }
}
