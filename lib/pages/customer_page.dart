// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/customer.dart';
import '../providers/customer_provider.dart';

class CustomerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var customerProvider = Provider.of<CustomerProvider>(context, listen: false);

    // Dummy data customer
    List<Customer> customers = [
      Customer(id: 1, name: 'John Doe', phoneNumber: '1234567890', address: '123 Main St'),
      Customer(id: 2, name: 'Jane Smith', phoneNumber: '9876543210', address: '456 Elm St'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          Customer customer = customers[index];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.phoneNumber),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                customerProvider.deleteCustomer(customer.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logic untuk menambahkan customer baru
          Customer newCustomer = Customer(
            id: customers.length + 1,
            name: 'New Customer',
            phoneNumber: 'New Phone Number',
            address: 'New Address',
          );
          customerProvider.addCustomer(newCustomer);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
