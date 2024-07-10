import 'dart:developer';

import 'package:laundry_app/database/db_helper.dart';
import 'package:laundry_app/database/query/customer_query.dart';
import 'package:laundry_app/models/customer.dart';

Future<List<CustomerModel>> getCustomers() async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // mengambil data dari table customer dengan raw query
  final query = await db.rawQuery(CustomerQuery.selectAll());
  // mengubah hasil query menjadi list
  List<CustomerModel> customers = [];
  for (var item in query) {
    // membuat objek Customer dari json
    customers.add(CustomerModel.fromJson(item));
  }
  return customers;
}

Future<int> insertCustomer(CustomerModel customer) async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // mengambil data dari table customer dengan raw query
  return await db.insert(CustomerQuery.tableName, customer.toJson());
}

Future<int> deleteCustomer(int id) async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // hapus data dari table customer yg id sama dengan parameter
  return await db
      .delete(CustomerQuery.tableName, where: 'id=?', whereArgs: [id]);
}

Future<int> updateCustomer(CustomerModel customer) async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // mengubah data dari table customer yg id sama dengan parameter
  try {
    log("customer : $customer");
    return await db.update(CustomerQuery.tableName, customer.toJson(),
        where: '${CustomerQuery.idColumn}=?', whereArgs: [customer.id]);
  } catch (e) {
    log('error update customer $e');
    return 0;
  }
}

Future<List<CustomerModel>> getCustomersByNameOrId(String value) async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // mengambil data dari table customer dengan raw query
  final query =
      await db.rawQuery(CustomerQuery.selectByIdOrName(), ["%$value%", value]);
  log("query : $query");
  log("value : $value");
  // mengubah hasil query menjadi list
  List<CustomerModel> customers = [];
  for (var item in query) {
    // membuat objek Customer dari json
    customers.add(CustomerModel.fromJson(item));
  }
  return customers;
}

Future<List<CustomerModel>> getCustomersByCreadtedAt(DateTime date) async {
  // inisiasi instance dari database
  final db = await DBHelper.instance.database;
  // mengambil data dari table customer dengan raw query
  final query = await db.rawQuery(CustomerQuery.selectByCreatedAt(), [date]);
  log("query : $query");
  log("value : $date");
  // mengubah hasil query menjadi list
  List<CustomerModel> customers = [];
  for (var item in query) {
    // membuat objek Customer dari json
    customers.add(CustomerModel.fromJson(item));
  }
  return customers;
}
