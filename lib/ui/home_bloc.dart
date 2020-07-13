import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherflut/data/repository/api_repository.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/model/city.dart';

class HomeBloc extends ChangeNotifier {
  List<City> cities = [];
  final StoreRepository storage;
  final ApiRepository apiService;
  bool loading = false;

  final formatDate = DateFormat('dd/MM/yyyy HH');

  HomeBloc({this.storage, this.apiService});

  void loadCities() async {
    final lastUpdate = await storage.getLastUpdate();
    final now = DateTime.now();
    final localCities = await storage.getCities();
    if (localCities.isEmpty) return;
    if (lastUpdate == null || (formatDate.format(now) != formatDate.format(lastUpdate))) {
      List<City> citiesUpdated = [];
      loading = true;
      notifyListeners();
      for (City city in localCities) {
        final cityUpdated = await apiService.getWeathers(city);
        citiesUpdated.add(cityUpdated);
      }
      await storage.saveCities(citiesUpdated);
      await storage.saveLastUpdate();
      cities = citiesUpdated;
      loading = false;
    } else {
      cities = await storage.getCities();
    }
    notifyListeners();
  }
}
