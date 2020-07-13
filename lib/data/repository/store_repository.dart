import 'package:weatherflut/model/city.dart';

abstract class StoreRepository {
  Future<void> saveCity(City city);
  Future<void> saveCities(List<City> cities);
  Future<List<City>> getCities();
  Future<DateTime> getLastUpdate();
  Future<void> saveLastUpdate();
  Future<void> deleteCity(City city);
}
