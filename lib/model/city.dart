class City {
  final String title;
  final int id;

  City({this.title, this.id});

  factory City.fromJson(Map<String, dynamic> map) {
    return City(
      id: map['woeid'],
      title: map['title'],
    );
  }
}
