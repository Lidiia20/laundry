import 'package:flutter/material.dart';
import 'package:laundry_app/models/customer.dart';
import 'package:laundry_app/models/transaction.dart';
import 'package:laundry_app/pages/customer/add_customer_page.dart';
import 'package:laundry_app/pages/customer/customer_page.dart';
import 'package:laundry_app/pages/customer/detail_customer_page.dart';
import 'package:laundry_app/pages/home/home_page.dart';
import 'package:laundry_app/pages/transaction/add_transaction_page.dart';
import 'package:laundry_app/pages/transaction/detail_transaction_page.dart';
import 'package:laundry_app/pages/transaction/transaction_page.dart';
import 'package:laundry_app/routes/route_names.dart';

class AppRoutes {
  const AppRoutes._();

  static Map<String, Widget Function(BuildContext)> generated = {
    RouteNames.home: (context) => const LaundryHomePage(),
    RouteNames.transaction: (context) => const TransactionPage(),
    RouteNames.addTransaction: (context) => const AddTransactionPage(),
    RouteNames.customer: (context) => CustomerPage(),
    RouteNames.addCustomer: (context) => const AddCustomerPage(),
    RouteNames.detailCustomer: (context) => DetailCustomerPage(
          customer: ModalRoute.of(context)!.settings.arguments
              as CustomerModel, // passing data dari route sebelumnya
        ),
    RouteNames.detailTransaction: (context) {
      final transaction =
          ModalRoute.of(context)!.settings.arguments as TransactionModel;
      return DetailTransactionPage(transaction: transaction);
    },
  };
}
