import 'package:flutter/material.dart';
import '../models/pickup.dart';
import '../database/db_helper.dart';

class PickupProvider with ChangeNotifier {
  List<Pickup> _pickups = [];
  final DBHelper _dbHelper = DBHelper.instance;

  List<Pickup> get pickups => _pickups;

  PickupProvider() {
    fetchPickups();
  }

  Future<void> fetchPickups() async {
    _pickups = await _dbHelper.fetchPickups();
    notifyListeners();
  }

  Future<void> addPickup(Pickup pickup) async {
    await _dbHelper.insertPickup(pickup);
    await fetchPickups();
  }

  Future<void> updatePickup(Pickup pickup) async {
    await _dbHelper.updatePickup(pickup);
    await fetchPickups();
  }

  Future<void> deletePickup(int id) async {
    await _dbHelper.deletePickup(id);
    await fetchPickups();
  }
}
