import 'package:flutter/material.dart';
import 'package:weatherflut/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherFlut',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}