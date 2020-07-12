import 'package:weatherflut/model/weather.dart';

class City {
  final String title;
  final int id;
  final List<Weather> weathers;

  City({
    this.title,
    this.id,
    this.weathers,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "woeid": id,
        "weathers": weathers.map((e) => e.toJson()).toList(),
      };

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      id: map['woeid'],
      title: map['title'],
    );
  }

  City fromWeathers(List<Weather> weathers) {
    return City(
      id: id,
      title: title,
      weathers: weathers,
    );
  }
}
