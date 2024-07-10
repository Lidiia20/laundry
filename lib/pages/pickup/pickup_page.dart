import 'package:flutter/material.dart';
import 'package:laundry_app/extensions/datetime_extension.dart';
import 'package:laundry_app/models/transaction.dart';
import 'package:laundry_app/pages/pickup/pickup_helper.dart';
import 'package:laundry_app/routes/route_names.dart';
import 'package:laundry_app/widgets/drawer/drawer_widget.dart';

class PickupPage extends StatefulWidget {
  const PickupPage({super.key});

  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  List<TransactionModel> transactions = [];
  DateTime? datetime = DateTime.now();

  @override
  void initState() {
    _getDataPickup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pickup'),
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                const Text("Tanggal pickup"),
                TextButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2035),
                          initialDate: datetime!);
                      setState(() {
                        datetime = date;
                        _getDataPickup();
                      });
                    },
                    child: Text(datetime?.formatDate() ?? "pilih tanggal")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (transactions.isEmpty)
              const Center(
                child: Text(
                  "Tidak ada data",
                  style: TextStyle(fontSize: 20),
                ),
              )
            else
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return ListTile(
                      title: Text(transaction.customer!.name),
                      onTap: () {
                        _onSelected(transaction);
                      },
                      subtitle: RichText(
                        text: TextSpan(
                            text: "tgl pickup :",
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: transaction.pickupDate.formatDate(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                              const TextSpan(
                                  text: "\ntgl delivery",
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: transaction.deliveryDate.formatDate(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ]),
                      ),
                    );
                  })
          ]),
        ));
  }

  void _getDataPickup() async {
    final data = await getPickupByDate(datetime ?? DateTime.now());
    setState(() {
      transactions = data;
    });
  }

  void _onSelected(TransactionModel transaction) {
    Navigator.pushNamed(context, RouteNames.detailTransaction,
        arguments: transaction);
  }
}
