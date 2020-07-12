import 'package:flutter/material.dart';
import 'package:weatherflut/data/repository/store_impl.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/model/city.dart';

class CitiesBloc extends ChangeNotifier {
  List<City> cities = [];
  final StoreRepository storage = StoreImpl();

  void loadCities() async {
    cities = await storage.getCities();
    notifyListeners();
  }
}
