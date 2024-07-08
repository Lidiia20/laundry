// ignore_for_file: unused_import, prefer_final_fields
import 'package:flutter/material.dart';
import '../foundation.dart';
import '../models/customer.dart';

class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners();
  }

  void updateCustomer(Customer customer) {
    int index = _customers.indexWhere((c) => c.id == customer.id);
    if (index != -1) {
      _customers[index] = customer;
      notifyListeners();
    }
  }

  void deleteCustomer(int id) {
    _customers.removeWhere((customer) => customer.id == id);
    notifyListeners();
  }
  
  void notifyListeners() {}
}
