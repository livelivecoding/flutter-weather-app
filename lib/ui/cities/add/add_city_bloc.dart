import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weatherflut/data/data_constants.dart';
import 'package:weatherflut/data/repository/store_impl.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/model/city.dart';
import 'package:weatherflut/model/weather.dart';
import 'package:weatherflut/ui/common/debouncer.dart';
import 'package:http/http.dart' as http;

class AddCityBloc extends ChangeNotifier {
  final debouncer = Debouncer();
  final StoreRepository storage = StoreImpl();
  List<City> cities = [];
  bool loading = false;
  String errorMessage;

  void onChangedText(String text) {
    debouncer.run(
      () {
        if (text.isNotEmpty) requestSearch(text);
      },
    );
  }

  void requestSearch(String text) async {
    loading = true;
    notifyListeners();

    final url = '${api}search/?query=$text';
    final response = await http.get(url);
    final data = jsonDecode(response.body) as List;

    loading = false;
    cities = data.map((e) => City.fromJson(e)).toList();
    notifyListeners();
  }

  Future<bool> addCity(City city) async {
    loading = true;
    notifyListeners();
    final url = '$api${city.id}';
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final weatherData = data['consolidated_weather'] as List;
    final weathers = weatherData.map((e) => Weather.fromJson(e)).toList();
    final newCity = city.fromWeathers(weathers);
    try {
      await storage.saveCity(newCity);
      errorMessage = null;
      return true;
    } on Exception catch (ex) {
      print(ex.toString());
      errorMessage = ex.toString();
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
