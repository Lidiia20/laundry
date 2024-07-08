// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pickup_provider.dart';
import '../models/pickup.dart'; // Make sure Pickup model is imported

class PickupPage extends StatelessWidget {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController serviceTypeController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController pickupDateController = TextEditingController();
  
  get provider => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Pickups'),
      ),
      body: Consumer<PickupProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.pickups.length,
            itemBuilder: (context, index) {
              final pickup = provider.pickups[index];
              return ListTile(
                title: Text(pickup.customerName),
                subtitle: Text('${pickup.serviceType} - ${pickup.totalPrice.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    provider.deletePickup(pickup.id!); // Ensure pickup.id is not null
                  },
                ),
                onTap: () {
                  customerNameController.text = pickup.customerName;
                  serviceTypeController.text = pickup.serviceType;
                  totalPriceController.text = pickup.totalPrice.toString();
                  pickupDateController.text = pickup.pickupDate.toIso8601String();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Update Pickup'),
                      content: Column(
                        children: [
                          TextField(
                            controller: customerNameController,
                            decoration: InputDecoration(labelText: 'Customer Name'),
                          ),
                          TextField(
                            controller: serviceTypeController,
                            decoration: InputDecoration(labelText: 'Service Type'),
                          ),
                          TextField(
                            controller: totalPriceController,
                            decoration: InputDecoration(labelText: 'Total Price'),
                          ),
                          TextField(
                            controller: pickupDateController,
                            decoration: InputDecoration(labelText: 'Pickup Date'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            provider.updatePickup(Pickup( // Ensure Pickup constructor is correctly defined in models/pickup.dart
                              id: pickup.id,
                              customerName: customerNameController.text,
                              serviceType: serviceTypeController.text,
                              totalPrice: double.parse(totalPriceController.text),
                              pickupDate: DateTime.parse(pickupDateController.text),
                            ));
                            Navigator.pop(context);
                          },
                          child: const Text('Update'), // Use const for better performance
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'), // Use const for better performance
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // Use const for better performance
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Pickup'),
              content: Column(
                children: [
                  TextField(
                    controller: customerNameController,
                    decoration: InputDecoration(labelText: 'Customer Name'),
                  ),
                  TextField(
                    controller: serviceTypeController,
                    decoration: InputDecoration(labelText: 'Service Type'),
                  ),
                  TextField(
                    controller: totalPriceController,
                    decoration: InputDecoration(labelText: 'Total Price'),
                  ),
                  TextField(
                    controller: pickupDateController,
                    decoration: InputDecoration(labelText: 'Pickup Date'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final newPickup = Pickup( // Ensure Pickup constructor is correctly defined in models/pickup.dart
                      customerName: customerNameController.text,
                      serviceType: serviceTypeController.text,
                      totalPrice: double.parse(totalPriceController.text),
                      pickupDate: DateTime.parse(pickupDateController.text),
                    );
                    provider.addPickup(newPickup);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'), // Use const for better performance
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'), // Use const for better performance
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
