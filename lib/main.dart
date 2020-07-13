import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherflut/data/repository/api_impl.dart';
import 'package:weatherflut/data/repository/api_repository.dart';
import 'package:weatherflut/data/repository/store_impl.dart';
import 'package:weatherflut/data/repository/store_repository.dart';
import 'package:weatherflut/ui/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(
          create: (_) => ApiImpl(),
        ),
        Provider<StoreRepository>(
          create: (_) => StoreImpl(),
        ),
      ],
      child: MaterialApp(
        title: 'WeatherFlut',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: HomePage(),
      ),
    );
  }
}
